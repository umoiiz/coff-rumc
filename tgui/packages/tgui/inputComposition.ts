/**
 * Let the input method handle candidate-selection keys before application
 * shortcuts (Enter, Escape, Tab and arrow keys) can submit or blur an input.
 * Capture is required because tgui-core inputs also handle these keys.
 */
export function setupInputComposition(): () => void {
  let composingTarget: EventTarget | null = null;

  const handleCompositionStart = (event: CompositionEvent) => {
    composingTarget = event.target;
  };
  const handleCompositionEnd = () => {
    composingTarget = null;
  };
  const handleKey = (event: KeyboardEvent) => {
    if (
      event.isComposing ||
      // Some browser/IME combinations end composition before the final key.
      event.keyCode === 229 ||
      (composingTarget !== null && event.target === composingTarget)
    ) {
      // Do not preventDefault: the browser must still commit the candidate.
      event.stopPropagation();
    }
  };

  document.addEventListener('compositionstart', handleCompositionStart, true);
  document.addEventListener('compositionend', handleCompositionEnd, true);
  document.addEventListener('blur', handleCompositionEnd, true);
  document.addEventListener('keydown', handleKey, true);
  document.addEventListener('keyup', handleKey, true);

  return () => {
    document.removeEventListener(
      'compositionstart',
      handleCompositionStart,
      true,
    );
    document.removeEventListener('compositionend', handleCompositionEnd, true);
    document.removeEventListener('blur', handleCompositionEnd, true);
    document.removeEventListener('keydown', handleKey, true);
    document.removeEventListener('keyup', handleKey, true);
  };
}
