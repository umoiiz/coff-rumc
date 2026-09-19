const groupNames = ['command', 'support', 'xeno', 'marine', 'flavour'] as const;
type GroupName = (typeof groupNames)[number];

/** Keep protocol group keys separate from localized job titles. */
export function getJobGroups(
  jobs: Record<string, unknown> = {},
  suppliedGroups: Partial<Record<GroupName, string[]>> = {},
): Record<GroupName | 'other', string[]> {
  const groups: Record<GroupName | 'other', string[]> = {
    command: [],
    support: [],
    xeno: [],
    marine: [],
    flavour: [],
    other: [],
  };
  const available = new Set(Object.keys(jobs).filter((title) => jobs[title]));
  for (const group of groupNames) {
    for (const title of suppliedGroups[group] ?? []) {
      if (available.delete(title)) groups[group].push(title);
    }
  }
  // Older servers lack groups; new/custom jobs may not have a group yet.
  // Show all remaining actual jobs instead of silently losing preferences.
  groups.other = [...available];
  return groups;
}
