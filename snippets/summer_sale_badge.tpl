{* Summer Sale Badge (Variante 3) — fkt_aktion: summersale11_2026 | summersale15_2026 · 27.07.–09.08.2026 *}
{assign var=summerSaleShow value=false}
{if isset($Artikel->FunktionsAttribute.fkt_aktion)}
    {if $Artikel->FunktionsAttribute.fkt_aktion == 'summersale11_2026'
        || $Artikel->FunktionsAttribute.fkt_aktion == 'summersale15_2026'}
        {assign var=ssHeute value=$smarty.now|date_format:'%Y%m%d'}
        {if $ssHeute >= '20260727' && $ssHeute <= '20260809'}
            {assign var=summerSaleShow value=true}
        {/if}
    {/if}
{/if}
{if $summerSaleShow}
<div class="summer-sale-badge-layer">
    <span class="summer-sale-badge" aria-label="Summer Sale">
        <span class="summer-sale-badge__summer">Summer</span>
        <span class="summer-sale-badge__sale">SALE</span>
    </span>
</div>
{/if}
