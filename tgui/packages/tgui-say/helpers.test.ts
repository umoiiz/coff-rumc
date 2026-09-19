import { describe, expect, it } from 'vitest';

import { limitText } from './helpers';

describe('speech character limits', () => {
  it('accepts text exactly at the character limit', () => {
    expect(limitText('中文', 2)).toBe('中文');
  });

  it('gives supplementary CJK characters the same allowance as BMP characters', () => {
    expect(limitText('𠀀𠀁中', 2)).toBe('𠀀𠀁');
  });

  it('does not split a surrogate pair at the boundary', () => {
    expect(limitText('A𠀀B', 2)).toBe('A𠀀');
  });

  it('reserves characters for the radio prefix sent to DM', () => {
    const prefix = ':a ';
    const entry = prefix + limitText('𠀀中文', 5 - prefix.length);
    expect(entry).toBe(':a 𠀀中');
    expect(Array.from(entry)).toHaveLength(5);
  });
});
