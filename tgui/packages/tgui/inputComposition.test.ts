import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

import { setupInputComposition } from './inputComposition';

describe('IME keyboard handling', () => {
  let input: HTMLTextAreaElement;
  let shortcut: ReturnType<typeof vi.fn>;
  let cleanup: () => void;

  beforeEach(() => {
    input = document.createElement('textarea');
    document.body.append(input);
    shortcut = vi.fn();
    input.addEventListener('keydown', shortcut);
    cleanup = setupInputComposition();
  });

  afterEach(() => {
    cleanup();
    input.remove();
  });

  function dispatchKey(
    key: string,
    marker?: { isComposing?: boolean; keyCode?: number },
  ) {
    const event = new KeyboardEvent('keydown', {
      key,
      bubbles: true,
      cancelable: true,
    });
    if (marker?.isComposing !== undefined) {
      Object.defineProperty(event, 'isComposing', {
        value: marker.isComposing,
      });
    }
    if (marker?.keyCode !== undefined) {
      Object.defineProperty(event, 'keyCode', { value: marker.keyCode });
    }
    input.dispatchEvent(event);
    return event;
  }

  it.each(['Enter', 'Escape', 'Tab', 'ArrowUp', 'ArrowDown'])(
    'leaves %s to the input method while selecting a candidate',
    (key) => {
      input.dispatchEvent(
        new CompositionEvent('compositionstart', { bubbles: true }),
      );
      const event = dispatchKey(key);

      expect(shortcut).not.toHaveBeenCalled();
      expect(event.defaultPrevented).toBe(false);
    },
  );

  it('allows Enter to submit after the candidate has been committed', () => {
    input.dispatchEvent(
      new CompositionEvent('compositionstart', { bubbles: true }),
    );
    input.dispatchEvent(
      new CompositionEvent('compositionend', { bubbles: true, data: '中文' }),
    );
    dispatchKey('Enter');

    expect(shortcut).toHaveBeenCalledOnce();
  });

  it.each([{ isComposing: true }, { keyCode: 229 }])(
    'honors native IME markers without a compositionstart event: %j',
    (marker) => {
      dispatchKey('Enter', marker);

      expect(shortcut).not.toHaveBeenCalled();
    },
  );

  it('does not leave shortcuts disabled when composition is cancelled by blur', () => {
    input.dispatchEvent(
      new CompositionEvent('compositionstart', { bubbles: true }),
    );
    input.dispatchEvent(new FocusEvent('blur'));
    dispatchKey('Enter');

    expect(shortcut).toHaveBeenCalledOnce();
  });
});
