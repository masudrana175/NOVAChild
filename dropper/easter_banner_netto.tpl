{*
  BEAUTEK Osteraktion – für Dropper (ab v100.20 mit Smarty 5) oder als Template-Include.
  Integration: https://kreativkonzentrat.de/Wiki/plugins/anpassung (u. a. *_custom.tpl im Plugin)
  Rabatt Netto-% = Brutto-Kupon-% × (1 + MwSt/100), wenn easterKuponIstNettoBasis = 0.
  Spar € = Referenz-Netto × (Netto-% / 100).
*}

{assign var=easterBruttoPct value=8}
{assign var=easterMwSt value=19}
{assign var=easterKuponIstNettoBasis value=0}
{assign var=easterBeispielNetto value=100}
{assign var=easterShowSpar value=1}
{assign var=easterKuponCode value='OSTERN8'}
{assign var=easterEnde value='2026-04-12T23:59:59+02:00'}

{if $easterKuponIstNettoBasis == 1}
    {assign var=easterAnzeigePct value=$easterBruttoPct}
{else}
    {assign var=easterAnzeigePct value=$easterBruttoPct * (100 + $easterMwSt) / 100}
{/if}

{assign var=easterAnzeigePctFmt value=$easterAnzeigePct|string_format:"%.2f"|replace:".":","}

{* Referenz-Netto für €-Zeile: hier ggf. durch Shop-Variable ersetzen, z. B. aus eigenem Plugin assign *}
{assign var=easterRefNetto value=$easterBeispielNetto}
{if isset($easterWarenkorbNetto) && $easterWarenkorbNetto > 0}
    {assign var=easterRefNetto value=$easterWarenkorbNetto}
{/if}

{assign var=easterSparEuro value=$easterRefNetto * $easterAnzeigePct / 100}
{assign var=easterSparEuroFmt value=$easterSparEuro|string_format:"%.2f"|replace:".":","}
{assign var=easterRefNettoFmt value=$easterRefNetto|string_format:"%.2f"|replace:".":","}

<div id="beautek-easter" class="easter-banner" hidden>
  <div class="easter-banner__content">

    <div class="easter-banner__left">
      <span class="easter-badge">OSTERAKTION</span>
      <div class="easter-offer">
        <span class="easter-discount" id="easter-discount-label" title="{$easterAnzeigePctFmt} % Rabatt bezogen auf den Nettopreis (Kupon {$easterBruttoPct} % auf Brutto, {$easterMwSt} % MwSt.)">
          <span class="easter-discount__num" aria-live="polite">{$easterAnzeigePctFmt}</span>% RABATT 🐰
        </span>
        <span class="easter-code-wrap">
          Code: <code class="easter-code">{$easterKuponCode}</code>
          <button type="button" class="easter-copy" onclick="copyEasterCode(event, this)">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
              <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
            </svg>
            <span class="copy-label">Code kopieren</span>
          </button>
        </span>
        {if $easterShowSpar == 1 && $easterRefNetto > 0}
        <span class="easter-savings" title="Beispielrechnung: {$easterSparEuroFmt} € Rabatt entsprechen {$easterAnzeigePctFmt} % vom Netto bzw. {$easterBruttoPct} % vom Bruttopreis.">
          Z. B. {$easterSparEuroFmt} € sparen bei {$easterRefNettoFmt} € Netto-Warenkorb
        </span>
        {/if}
      </div>
    </div>

    <div class="easter-banner__right">
      <span class="countdown-label">Endet in</span>
      <div class="countdown">
        <div class="countdown__block">
          <span class="countdown__num" data-cd="d">00</span>
          <span class="countdown__unit">Tage</span>
        </div>
        <span class="countdown__sep">:</span>
        <div class="countdown__block">
          <span class="countdown__num" data-cd="h">00</span>
          <span class="countdown__unit">Std</span>
        </div>
        <span class="countdown__sep">:</span>
        <div class="countdown__block">
          <span class="countdown__num" data-cd="m">00</span>
          <span class="countdown__unit">Min</span>
        </div>
        <span class="countdown__sep">:</span>
        <div class="countdown__block">
          <span class="countdown__num" data-cd="s">00</span>
          <span class="countdown__unit">Sek</span>
        </div>
      </div>
    </div>

  </div>
  <div class="easter-deco" aria-hidden="false">
    <button type="button" class="bunny-track" onclick="showBunnyBubble(event)" aria-label="Osterhase anklicken">
      <span class="bunny-speech" id="bunnySpeech">Frohe Ostern!</span>
      <span class="bunny">🐇</span>
    </button>
  </div>
</div>

{literal}
<style>
.easter-banner {
  position: sticky;
  top: 90px;
  z-index: 999;
  background:
    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.16) 0%, rgba(255,255,255,0) 30%),
    linear-gradient(135deg, #6f1246 0%, #841853 48%, #b45a84 100%);
  color: #fff;
  font-family: system-ui, -apple-system, sans-serif;
  overflow: hidden;
  box-shadow: 0 10px 26px rgba(68, 10, 41, 0.18);
}

.easter-banner__content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  max-width: 1400px;
  margin: 0 auto;
  padding: 14px 24px 18px;
  position: relative;
  z-index: 2;
}

.easter-banner__left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.easter-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  background: rgba(255,255,255,0.18);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.18);
  border-radius: 50px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  white-space: nowrap;
}

.easter-offer {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

.easter-discount {
  font-size: 18px;
  font-weight: 800;
  letter-spacing: -0.01em;
}

.easter-discount__num {
  font-variant-numeric: tabular-nums;
}

.easter-savings {
  flex-basis: 100%;
  font-size: 13px;
  font-weight: 600;
  line-height: 1.35;
  opacity: 0.94;
  margin: 0;
}

.easter-code-wrap {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  font-weight: 500;
  flex-wrap: wrap;
}

.easter-code {
  display: inline-block;
  padding: 6px 12px;
  background: #fff;
  color: #841853;
  border-radius: 8px;
  font-family: "SF Mono", "Consolas", monospace;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.05em;
  box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.easter-copy {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  background: rgba(255,255,255,0.14);
  border: 1px solid rgba(255,255,255,0.28);
  border-radius: 8px;
  color: #fff;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  appearance: none;
  -webkit-appearance: none;
}

.easter-copy:hover {
  background: #fff;
  color: #841853;
  border-color: #fff;
}

.easter-copy.copied {
  background: #d7f5e7;
  border-color: #d7f5e7;
  color: #1b7f4d;
}

.easter-banner__right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.countdown-label {
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  opacity: 0.92;
}

.countdown {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 8px 14px;
  background: rgba(0,0,0,0.18);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.16);
  border-radius: 12px;
}

.countdown__block {
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 36px;
}

.countdown__num {
  font-size: 20px;
  font-weight: 800;
  font-variant-numeric: tabular-nums;
  line-height: 1;
}

.countdown__unit {
  font-size: 9px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  opacity: 0.82;
  margin-top: 2px;
}

.countdown__sep {
  font-size: 18px;
  font-weight: 700;
  opacity: 0.6;
  margin: 0 2px;
  align-self: flex-start;
  margin-top: 2px;
}

.easter-deco {
  position: absolute;
  inset: 0;
  overflow: hidden;
  z-index: 3;
  pointer-events: none;
}

.bunny-track {
  position: absolute;
  left: -28px;
  bottom: 0;
  animation: bunnyRun 13s linear infinite;
  background: transparent;
  border: 0;
  padding: 0;
  cursor: pointer;
  pointer-events: auto;
}

.bunny {
  display: inline-block;
  font-size: 18px;
  transform: scaleX(-1);
  animation: bunnyHop .55s ease-in-out infinite;
}

.bunny-speech {
  position: absolute;
  bottom: 24px;
  left: 50%;
  transform: translateX(-50%) translateY(6px);
  background: #fff;
  color: #841853;
  font-size: 12px;
  font-weight: 700;
  padding: 6px 10px;
  border-radius: 12px;
  white-space: nowrap;
  box-shadow: 0 6px 16px rgba(0,0,0,0.14);
  opacity: 0;
  visibility: hidden;
  transition: all 0.2s ease;
}

.bunny-speech::after {
  content: "";
  position: absolute;
  left: 50%;
  bottom: -6px;
  transform: translateX(-50%) rotate(45deg);
  width: 10px;
  height: 10px;
  background: #fff;
}

.bunny-speech.is-visible {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
}

@keyframes bunnyRun {
  0%   { left: -28px; }
  100% { left: calc(100% + 28px); }
}

@keyframes bunnyHop {
  0%, 100% { transform: scaleX(-1) translateY(0); }
  50% { transform: scaleX(-1) translateY(-4px); }
}

@media (max-width: 768px) {
  .easter-banner__content {
    flex-direction: column;
    gap: 12px;
    padding: 12px 16px 18px;
    text-align: center;
  }

  .easter-banner__left,
  .easter-banner__right {
    justify-content: center;
  }

  .easter-offer {
    flex-direction: column;
    gap: 8px;
  }

  .easter-discount {
    font-size: 16px;
  }

  .easter-savings {
    font-size: 12px;
  }

  .countdown__block {
    min-width: 32px;
  }

  .countdown__num {
    font-size: 16px;
  }

  .bunny {
    font-size: 16px;
  }

  .bunny-speech {
    font-size: 11px;
    padding: 5px 9px;
    bottom: 22px;
  }
}
</style>
{/literal}

{* Countdown-Ende + Kupon aus Smarty an JS übergeben *}
<script>
window.__easterBannerCfg = {
  deadline: "{$easterEnde|escape:'html'}",
  kuponCode: "{$easterKuponCode|escape:'html'}"
};
</script>

{literal}
<script>
(function(){
  var cfg = window.__easterBannerCfg || {};
  var banner = document.getElementById('beautek-easter');
  if (!banner) return;

  var deadline = new Date(cfg.deadline || '2026-04-12T23:59:59+02:00');

  var els = {
    d: banner.querySelector('[data-cd="d"]'),
    h: banner.querySelector('[data-cd="h"]'),
    m: banner.querySelector('[data-cd="m"]'),
    s: banner.querySelector('[data-cd="s"]')
  };

  function pad(n) {
    return String(n).padStart(2, '0');
  }

  function tick() {
    var diff = deadline - new Date();

    if (diff <= 0) {
      banner.remove();
      return;
    }

    var sec = Math.floor(diff / 1000);
    els.d.textContent = pad(Math.floor(sec / 86400));
    els.h.textContent = pad(Math.floor((sec % 86400) / 3600));
    els.m.textContent = pad(Math.floor((sec % 3600) / 60));
    els.s.textContent = pad(sec % 60);

    if (banner.hidden) banner.hidden = false;
  }

  tick();
  setInterval(tick, 1000);
})();

function copyEasterCode(event, btn) {
  if (event) {
    event.preventDefault();
    event.stopPropagation();
  }

  var code = (window.__easterBannerCfg && window.__easterBannerCfg.kuponCode) ? window.__easterBannerCfg.kuponCode : 'OSTERN8';

  navigator.clipboard.writeText(code).then(function() {
    var label = btn.querySelector('.copy-label');
    var originalText = label.textContent;

    btn.classList.add('copied');
    label.textContent = 'Kopiert';

    setTimeout(function() {
      btn.classList.remove('copied');
      label.textContent = originalText;
    }, 2000);
  });

  return false;
}

function showBunnyBubble(event) {
  if (event) {
    event.preventDefault();
    event.stopPropagation();
  }

  var bubble = document.getElementById('bunnySpeech');
  if (!bubble) return false;

  bubble.classList.remove('is-visible');
  void bubble.offsetWidth;
  bubble.classList.add('is-visible');

  clearTimeout(window.__bunnyBubbleTimeout);
  window.__bunnyBubbleTimeout = setTimeout(function() {
    bubble.classList.remove('is-visible');
  }, 1800);

  return false;
}
</script>
{/literal}
