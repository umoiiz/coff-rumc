import { describe, expect, it } from 'vitest';

import { getJobGroups } from '../interfaces/PlayerPreferences/jobGroups';

describe('job preference groups', () => {
  it('preserves localized titles as the lookup and action keys', () => {
    const groups = getJobGroups(
      { 舰长: { banned: false }, 医生: { banned: true } },
      { command: ['舰长'], support: ['医生'] },
    );
    expect(groups.command).toEqual(['舰长']);
    expect(groups.support).toEqual(['医生']);
    expect(groups.other).toEqual([]);
  });

  it('preserves supplied ordering and skips unavailable or duplicate jobs', () => {
    const groups = getJobGroups(
      { Captain: {}, AI: {}, Synthetic: undefined },
      { command: ['AI', 'Synthetic', 'Captain', 'AI'], support: ['Captain'] },
    );
    expect(groups.command).toEqual(['AI', 'Captain']);
    expect(groups.support).toEqual([]);
  });

  it('keeps custom jobs visible even if no group includes them', () => {
    expect(
      getJobGroups({ Captain: {}, 自定义职业: {} }, { command: ['Captain'] })
        .other,
    ).toEqual(['自定义职业']);
  });

  it('supports old servers without group metadata in any language', () => {
    expect(getJobGroups({ Captain: {}, 医生: {} }).other).toEqual([
      'Captain',
      '医生',
    ]);
  });

  it('accepts missing job data while the interface initializes', () => {
    expect(getJobGroups().other).toEqual([]);
  });
});
