# 简体中文翻译准备：源码审查与修复

审查基线：`f39adc0483178188ae9a7f750038c269a1e02abe`。本次修改面向字符串被翻译之后的运行行为，没有批量翻译游戏文案，也没有实现翻译器。按任务约定，字符串插值的遮罩、翻译和回填由后续流程处理。

## 审查计划与判断标准

1. 从 `tgmc.dme` 阅读编译入口、全局定义、控制器、DM 输出链路和浏览器前端，确定实际执行入口。
2. 对照 [BYOND DM Reference](http://www.byond.com/docs/ref/#/DM)，重点核对 Unicode、字符串索引、`output`、`browse`、`maptext`、`client.MeasureText` 和皮肤规则。
3. 沿玩家发言、系统提示、头顶文字、图标气泡、打字动画和输入框追踪字符串；每个节点均检查“换成简体中文后是否改变长度、判定、显示或操作结果”。
4. 检查显示名称是否被当作机器标识使用，修复会把中文清空或造成碰撞的路径。
5. 修复共用入口并接入现有编译／前端入口；用中文、英文、边界长度和已有存档格式验证。

## 架构和输出路径

| 层次 | 关键入口 | 运行职责和中文化关注点 |
| --- | --- | --- |
| 编译 | `tgmc.dme`、`code/_compile_options.dm`、`dependencies.sh` | DME 显式 include DM 源文件；项目指定 BYOND 516.1659。新测试经 `_unit_tests.dm` 接入，正常游戏代码直接位于既有 include 文件中。 |
| 全局定义 | `code/__DEFINES`、`code/_globalvars`、`code/controllers/globals.dm` | `GLOBAL_*` 宏把变量和初始化函数放入 `GLOB` 控制器；共享标点、长度限制、字体宏、语言实例等会影响多个系统。 |
| 子系统 | `code/controllers/master.dm`、`code/controllers/subsystem` | Master 调度各 SS；`SSchat` 排队输出聊天，`SSrunechat` 调度头顶文字，`SStgui` 管理交互界面。 |
| 玩家发言 | `code/modules/mob/living/say.dm`、`code/game/say.dm` | `say → send_speech → Hear → compose_message / lang_treat / say_quote → to_chat`，处理说话范围、收听权限、无线电、语言理解、动词和强调样式。 |
| 系统与特殊情况提示 | `code/modules/mob/mob.dm`、`code/modules/tgchat/to_chat.dm` | `visible_message`、`audible_message` 按可见性／听力选接收者；`to_chat` 经 `SSchat` 和 TGUI panel 输出。自身提示、盲／聋替代提示与普通消息是不同分支。 |
| 图标气泡 | `say_test()`、`code/modules/mob/living/say.dm` | 句尾问号／感叹号选择图标状态；这里不是字符串排版，必须保留图标状态等协议值。 |
| Runechat | `code/datums/chatmessage.dm` | 以 `maptext` 显示头顶文字；宽度 112 像素，高度由客户端 `MeasureText` 决定，并参与堆叠／淡出。 |
| 浮动提示 | `code/modules/balloon_alert/balloon_alert.dm` | `balloon_alert(viewer, text)` 只给指定玩家显示；宽度 200 像素，高度测量，寿命随文本长度变化。 |
| 屏幕打字提示 | `code/modules/screen_alert` | `play_screen_text` 排队播放逐字动画；正文和 HTML 标签位置必须使用相同索引单位。 |
| 旧浏览器窗口 | `code/datums/browser.dm`、`html/browser` | DM 生成 HTML，通过 `browse` 与资源缓存交付；编码声明、CSS、原生窗口大小分别控制显示。 |
| TGUI | `code/modules/tgui`、`code/modules/tgui_input`、`tgui/packages` | DM 提供 `ui_data`／`ui_static_data`，React 显示并通过 `ui_act` 回传操作；UI 动作 ID 与字段键属于协议。 |
| 字体和地图皮肤 | `interface/skin.dmf`、`interface/stylesheet.dm`、`code/__DEFINES/text.dm` | maptext、旧聊天、浏览器和 TGUI 使用不同样式入口，修改一处不会自动覆盖所有出口。 |

DM 的 `length`、`copytext` 等旧函数对文本使用字节单位，`length_char`、`copytext_char`、`findtext_char` 使用字符单位。既有按字节扫描 UTF-8 后再以字节偏移截取的完整算法、哈希和协议解析不能机械替换。本次按调用的真实用途区分处理。字符数也不等于实际像素宽度；排版仍需客户端测量或可滚动容器。

## 已修复的问题

| 原有风险 | 修改后的行为 |
| --- | --- |
| `？`、`！`、`。` 未被多个发言分支识别，可能出现额外英文句号或失去问句／喊话效果 | 共用中英文标点集合；说话动词、图标气泡、语言扰乱、表情和 Runechat 强调识别全角标点。 |
| emote 使用另一个字符串的长度取句尾 | 改为读取最终 `msg` 的最后一个完整字符。 |
| 中文被按 UTF-8 字节计入刷屏权重、气泡寿命和输入上限 | 按字符计数，避免同等字数的中文被额外计权、过长停留或触发超限错误。 |
| `TextPreview` 的 Unicode 分支判断不可达，截取长度写死 | 按调用方给出的字符上限截断并预留省略号；短上限和中文边界有回归测试。 |
| HTML 清理、屏幕动画、头像姓名存在字节／字符混用 | 清理和姓名截断保留完整汉字，动画标签位置和逐字进度统一为字符索引。 |
| Runechat 测量时缺少最终 `.maptext` 外层，balloon 只测裸文本 | 测量和渲染使用同一段完整 markup，字体、字号、对齐等参与实际高度计算。 |
| 旧浏览器同时声明 UTF-8 和 ISO-8859-1 | 统一为 UTF-8。 |
| 多条字体链仅指定西文字体或像素字体 | 追加 `Microsoft YaHei UI`、`Microsoft YaHei`、`Noto Sans CJK SC` 和通用后备字体，覆盖主要地图、浏览器、聊天、状态面板和 TGUI 入口。 |
| IME 候选确认键可能被 Enter 提交、Escape 关闭或 Tab／方向键切换抢走 | 在三个 TGUI 入口捕获组合态键盘事件，不取消浏览器默认候选操作；TGUI Say 另加本地组合态保护。 |
| TGUI Say 使用 UTF-16 长度，恰好上限时不发送，无线电前缀可能使服务端超限 | 按 Unicode 码点限制，接受恰好上限，发送前为前缀保留空间；组合完成后再截断。 |
| 中文比拉丁文更早换行，输入框滚动却依赖固定字符阈值 | 输入框按实际溢出自动出现纵向滚动，长文本始终可查看。 |
| 化学名称经 `ckey()` 变成操作 ID；中文可能清空、碰撞，录制预览还会从 ID 猜显示名 | 新 UI、录制和保存使用 reagent 类型路径；显示名单独由服务端发送。77 个历史分配器英文别名冻结为兼容映射；新旧配方先规范化并验证全部条目。 |
| 身份卡电脑比较 `ckey(job.title)`，中文职业可能互相匹配 | 使用保留中文字符的大小写无关比较，避免分配错误职业权限。 |
| 两个 `balloon_alert` 调用漏掉 viewer 参数 | 补全接收者，使扫描时的操作提示和异形超出范围提示能够显示。 |

## 文件级差异清单

完整逐行增加／删除内容见同目录的 `localization-preparation.patch`；补丁涵盖全部 46 个源码与测试文件（修改 41 个、新增 5 个），包括未跟踪的新文件。另新增本报告和补丁这两个交付文件，没有删除文件。下面按文件列出用途，便于审查。

### DM 运行代码

| 文件 | 变更 |
| --- | --- |
| `code/__DEFINES/admin.dm` | 刷屏权重改为字符数。 |
| `code/__DEFINES/say.dm` | 新增共用中英文句末、疑问、感叹和喊话标点集合。 |
| `code/__DEFINES/text.dm` | maptext 字体回退；HTML 清理按字符截断。 |
| `code/__HELPERS/text.dm` | 重写 `TextPreview` 的限长逻辑。 |
| `code/datums/browser.dm` | 浏览器编码统一 UTF-8。 |
| `code/datums/chatmessage.dm` | 全角喊话标点；测量与渲染 markup 一致。 |
| `code/datums/emotes.dm` | 修复最终表情消息的句尾判断。 |
| `code/datums/health_scan/health_scan.dm` | 补扫描提示的接收者。 |
| `code/game/objects/items/books/manuals.dm` | 内嵌手册 HTML 字体回退。 |
| `code/game/objects/machinery/computer/marines_consoles.dm` | 职业名称匹配保留中文。 |
| `code/game/say.dm` | 中文标点对应正确动词、强调和气泡。 |
| `code/modules/balloon_alert/balloon_alert.dm` | 完整 markup 测量；显示寿命按字符数。 |
| `code/modules/language/language.dm` | 语言扰乱保留中文标点；正确选取问句和感叹动词。 |
| `code/modules/mob/living/carbon/xenomorph/castes/behemoth/abilities_behemoth.dm` | 补超出范围提示的接收者。 |
| `code/modules/mob/living/say.dm` | 最后字符和句末标点处理。 |
| `code/modules/mob/living/silicon/say.dm` | 硅基生物的同类句尾修复。 |
| `code/modules/reagents/chemistry/reagents.dm` | 稳定类型 ID 注册和 77 个历史别名兼容映射。 |
| `code/modules/reagents/chemistry/machinery/chem_dispenser.dm` | 稳定 ID 操作、配方规范化和独立显示名称。 |
| `code/modules/screen_alert/_screen_alert.dm` | 屏幕打字动画按字符索引。 |
| `code/modules/screen_alert/misc_alert.dm` | 头像姓名按字符限长。 |
| `code/modules/tgui_input/say_modal/speech.dm` | 聊天上限和受伤截断按字符计数。 |
| `code/modules/tgui_input/text.dm` | 通用文本输入上限和编码后限长提示按字符判断。 |

### 字体、前端和输入

| 文件 | 变更 |
| --- | --- |
| `html/browser/common.css` | 旧浏览器共享字体回退。 |
| `html/browser/create_object.html` | 对象创建页面字体回退。 |
| `html/statbrowser.css` | 状态面板字体回退。 |
| `html/admin/view_variables.css` | 变量查看页面正文与等宽字段字体回退。 |
| `interface/skin.dmf` | 地图 maptext 各主要样式的字体回退。 |
| `interface/stylesheet.dm` | DM 内嵌样式中的正文和特殊消息字体回退。 |
| `tgui/packages/tgui/styles/reset.scss` | 全局正文和等宽字体变量追加中文字体。 |
| `tgui/packages/tgui-escape-menu/styles/main.scss` | 退出菜单字体回退。 |
| `tgui/packages/tgui-panel/settings/middleware.ts` | 用户自定义聊天字体仍保留 CJK 后备字体。 |
| `tgui/packages/tgui-panel/styles/tgchat/chat-dark.scss` | 深色聊天消息样式字体回退。 |
| `tgui/packages/tgui-panel/styles/tgchat/chat-light.scss` | 浅色聊天消息样式字体回退。 |
| `tgui/packages/tgui/inputComposition.ts`（新增） | 共享输入法组合态键盘事件保护。 |
| `tgui/packages/tgui/index.tsx` | 主界面启用输入法保护。 |
| `tgui/packages/tgui-panel/index.tsx` | 聊天面板启用输入法保护。 |
| `tgui/packages/tgui-say/index.tsx` | 聊天输入窗口启用输入法保护。 |
| `tgui/packages/tgui-say/TguiSay.tsx` | 组合态、Unicode 长度、临界上限和无线电前缀处理。 |
| `tgui/packages/tgui-say/helpers.ts` | 新增 Unicode 码点截断函数 `limitText`。 |
| `tgui/packages/tgui-say/styles/styles.scss` | 中文提前换行时允许自动滚动。 |
| `tgui/packages/tgui/interfaces/ChemDispenser.jsx` | 录制预览使用服务端显示名。 |

### 回归测试

| 文件 | 变更 |
| --- | --- |
| `code/modules/unit_tests/_unit_tests.dm` | 注册两个本地化测试文件。 |
| `code/modules/unit_tests/localization.dm`（新增） | 中文／ASCII 气泡、预览截断、HTML 清理及长度边界。 |
| `code/modules/unit_tests/localization_identifiers.dm`（新增） | reagent ID、旧宏兼容、中文名称互不碰撞、savefile 往返和配方验证。 |
| `tgui/packages/tgui/inputComposition.test.ts`（新增） | IME 候选键、原生标记和取消组合态。 |
| `tgui/packages/tgui-say/helpers.test.ts`（新增） | 恰好上限、补充平面汉字、代理对边界和前缀限长。 |

## 验证记录

使用项目要求的 BYOND 516.1659 验证最终源码，结果如下：

| 验证 | 结果与范围 |
| --- | --- |
| 普通模式全量编译 | 0 errors、0 warnings。 |
| `UNIT_TESTS` 模式全量编译 | 0 errors、1 warning；仅项目既有的 `loop_checks` 警告。两个新增 DM 测试均参与编译。 |
| DM 文本回归实际运行 | 20/20 项断言通过，覆盖中英文标点、完整汉字截断、临界长度和 HTML 清理。 |
| DM 化学标识回归实际运行 | 487/487 项断言通过，覆盖 467 个正式试剂类型和 2 个中文测试类型，以及旧配方、混合 ID 合并、非法配方和原生 BYOND savefile 往返。 |
| TGUI 测试 | 9 个测试文件、48 项测试全部通过，其中新增 9 项输入法事件测试和 4 项 Unicode 限长测试。 |
| TGUI 正式资源构建 | `tgui:build` 成功。生成资源由 Git 忽略；部署仍应使用项目正常构建流程。 |
| 前端代码检查 | 本次变更的 TS／TSX／JSX 文件通过 ESLint；相关前端代码及 SCSS 通过 Prettier 检查。仓库全量 TypeScript 检查仍有既有错误，不能宣称全仓类型检查通过。 |
| 补丁格式检查 | `git diff --check` 通过；完整补丁通过反向应用检查，46 个文件与报告清单逐一对应。 |

507 项 DM 断言在隔离的 DreamDaemon 环境中实际执行：直接提取当前源码函数、467 个正式试剂类型声明，并 include 两个正式测试文件。隔离环境替代了地图和机器初始化，因此它验证的是文本算法、标识与存档行为，不等同于完整游戏世界中的机器交互验收。普通和测试模式均另行进行了完整工程编译。

编译使用临时工程名，未覆盖正式 `tgmc.dmb`／`tgmc.rsc`；临时编译和运行文件均已清理。没有启动实际 BYOND 玩家客户端，因此地图字体清晰度、长译文排版和真实输入法候选窗口仍需客户端验收。

## 后续翻译应保留的约束

- 显示文本可翻译，类型路径、资源路径、`icon_state`、CSS class、TGUI `act` 动作名、JSON 字段、网络频道键和历史存档别名必须保持协议含义。尤其不要翻译 `build_name2reagent()` 中冻结的英文别名。
- 某些岗位、阵营、枚举常量同时承担显示值和内部匹配职责，不能对同一值的定义／引用进行不一致的翻译。本次消除了已确认的化学 ID 和职业 `ckey()` 碰撞，没有把整个仓库迁移为独立翻译键体系。
- 已有 `reject_bad_text()` 包含基本汉字、扩展 A 和全角标点范围；角色姓名的 `reject_bad_name()` 仍有其独立命名规则。允许哪些玩家自定义姓名是另一项行为设置，不能把它与 NPC 文案翻译混为一谈。
- `interface/fonts/spess_font.dm` 的静态 metrics 范围为 30–255，不能据此计算汉字宽度；仓库搜索没有发现 `get_metrics()` 的调用方。本次没有用这张表替代客户端 `MeasureText`。
- 字体回退依赖客户端实际安装的字体。本次没有打包大型 CJK 字体文件；BYOND 地图小字号（例如 7px、6pt）是否足够清晰仍需实际客户端评估。
- Runechat 和 balloon 使用动态高度，但屏幕剧情提示、头像姓名条和部分 HUD 仍有固定容器／字号。字符安全不等于无限容纳译文：正式翻译时需对这些定长界面做逐页视觉验收，必要时缩短文案或调整专用布局。
- 输入法测试模拟浏览器事件；不同 Windows 输入法和 BYOND WebView 的候选窗口行为仍应在真实客户端验收。
- 通过项目正常构建流程生成并部署 TGUI 资源；只编译 DM、却继续发布旧前端 bundle，不会启用前端修复。
