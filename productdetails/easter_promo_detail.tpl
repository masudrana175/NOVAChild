{*
  Osteraktion – nur Artikeldetail. Kupon auf Brutto, Anzeige Netto-% und €-Ersparnis pro Stück (Netto).
*}
{assign var=easterBruttoPct value=8}
{assign var=easterKuponIstNettoBasis value=0}
{assign var=easterKuponCode value='OSTERN8'}

{assign var=easterMwSt value=19}
{if isset($Artikel->taxData.tax) && $Artikel->taxData.tax > 0}
    {assign var=easterMwSt value=$Artikel->taxData.tax}
{/if}

{if $easterKuponIstNettoBasis == 1}
    {assign var=easterAnzeigePct value=$easterBruttoPct}
{else}
    {assign var=easterAnzeigePct value=$easterBruttoPct * (100 + $easterMwSt) / 100}
{/if}
{assign var=easterAnzeigePctFmt value=$easterAnzeigePct|string_format:"%.2f"|replace:".":","}

{assign var=easterRefNetto value=$Artikel->Preise->fVKNetto}
{if isset($Artikel->Preise->oPriceRange) && $Artikel->Preise->oPriceRange->isRange() && ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0}
    {assign var=easterRefNetto value=$Artikel->Preise->oPriceRange->minNettoPrice}
{/if}

{assign var=easterSparEuro value=$easterRefNetto * $easterAnzeigePct / 100}
{assign var=easterSparEuroFmt value=$easterSparEuro|string_format:"%.2f"|replace:".":","}
{assign var=easterRefNettoFmt value=$easterRefNetto|string_format:"%.2f"|replace:".":","}

{if $easterRefNetto > 0}
<div class="product-easter-promo" role="note">
    <div class="product-easter-promo__inner">
        <span class="product-easter-promo__badge">Osteraktion</span>
        <span class="product-easter-promo__pct">
            <strong>{$easterAnzeigePctFmt}&nbsp;%</strong> Rabatt auf den Nettopreis
        </span>
        <span class="product-easter-promo__save">
            Du sparst <strong>{$easterSparEuroFmt}&nbsp;€</strong> pro Stück (Netto-Stückpreis {$easterRefNettoFmt}&nbsp;€)
        </span>
        <span class="product-easter-promo__code">
            Code <code>{$easterKuponCode}</code>
            <button type="button" class="product-easter-promo__copy" data-easter-copy="{$easterKuponCode|escape:'html'}">
                Kopieren
            </button>
        </span>
    </div>
</div>

{literal}
<style>
.product-easter-promo {
    margin-top: 0.75rem;
    margin-bottom: 0.5rem;
    border-radius: 10px;
    background: linear-gradient(135deg, #6f1246 0%, #841853 55%, #b45a84 100%);
    color: #fff;
    font-size: 13px;
    line-height: 1.45;
    box-shadow: 0 6px 18px rgba(68, 10, 41, 0.15);
}
.product-easter-promo__inner {
    padding: 12px 14px;
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.product-easter-promo__badge {
    display: inline-block;
    align-self: flex-start;
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    background: rgba(255,255,255,0.2);
}
.product-easter-promo__pct strong {
    font-size: 1.05em;
}
.product-easter-promo__save {
    opacity: 0.96;
}
.product-easter-promo__code {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 8px;
    margin-top: 2px;
}
.product-easter-promo__code code {
    background: #fff;
    color: #841853;
    padding: 4px 10px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
}
.product-easter-promo__copy {
    padding: 4px 10px;
    font-size: 12px;
    font-weight: 600;
    border-radius: 6px;
    border: 1px solid rgba(255,255,255,0.35);
    background: rgba(255,255,255,0.15);
    color: #fff;
    cursor: pointer;
}
.product-easter-promo__copy:hover {
    background: #fff;
    color: #841853;
}
.product-easter-promo__copy.is-done {
    background: #d7f5e7;
    border-color: #d7f5e7;
    color: #1b7f4d;
}
</style>
<script>
(function(){
  document.querySelectorAll('.product-easter-promo__copy').forEach(function(btn){
    btn.addEventListener('click', function(){
      var c = btn.getAttribute('data-easter-copy') || '';
      if (!c || !navigator.clipboard) return;
      navigator.clipboard.writeText(c).then(function(){
        btn.classList.add('is-done');
        var t = btn.textContent;
        btn.textContent = 'Kopiert';
        setTimeout(function(){
          btn.classList.remove('is-done');
          btn.textContent = t;
        }, 1800);
      });
    });
  });
})();
</script>
{/literal}
{/if}
