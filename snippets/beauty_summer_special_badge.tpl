{* Beauty Summer Special — fkt_aktion = beautysummerspecials, gültig bis 30.06.2026 *}
{assign var=bssShow value=false}
{if isset($Artikel->FunktionsAttribute.fkt_aktion)}
    {if $Artikel->FunktionsAttribute.fkt_aktion == 'beautysummerspecials'}
        {assign var=bssHeute value=$smarty.now|date_format:'%Y%m%d'}
        {if $bssHeute <= '20260630'}
            {assign var=bssShow value=true}
        {/if}
    {/if}
{/if}
{if $bssShow}
<div class="beauty-summer-special-badge-layer">
    <span class="beauty-summer-special-badge" aria-label="Summer Special -15%">
        <span class="beauty-summer-special-badge__summer">Summer</span>
        <span class="beauty-summer-special-badge__line">Special</span>
        <span class="beauty-summer-special-badge__discount">-15%</span>
    </span>
</div>
{/if}
