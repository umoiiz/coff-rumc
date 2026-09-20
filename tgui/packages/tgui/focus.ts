/**
 * Various focus helpers.
 *
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

/**
 * Returns keyboard focus to gameplay. A non-text native button suspends IME
 * composition without changing the user's input language for chat inputs.
 */
export const focusMap = () => {
  Byond.winset('mapwindow.keyboard_focus', {
    focus: true,
  });
};

/**
 * Moves focus to the browser window.
 */
export const focusWindow = () => {
  Byond.winset(Byond.windowId, {
    focus: true,
  });
};
