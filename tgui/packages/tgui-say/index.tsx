import { createRoot, Root } from 'react-dom/client';
import { setupInputComposition } from 'tgui/inputComposition';

import { TguiSay } from './TguiSay';

let reactRoot: Root | null = null;

setupInputComposition();

document.onreadystatechange = function () {
  if (document.readyState !== 'complete') return;

  if (!reactRoot) {
    const root = document.getElementById('react-root');
    reactRoot = createRoot(root!);
  }

  reactRoot.render(<TguiSay />);
};
