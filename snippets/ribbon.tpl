{block name='snippets-ribbon'}
    {if !empty($Artikel->Preise->Sonderpreis_aktiv)}
        {$sale = $Artikel->Preise->discountPercentage}
    {/if}

    {* Summer Sale: SALE-Snippet (ribbon-2) ausblenden — Badge kommt als Overlay *}
    {assign var=summerSaleHideSaleRibbon value=false}
    {if isset($Artikel->FunktionsAttribute.fkt_aktion)}
        {if $Artikel->FunktionsAttribute.fkt_aktion == 'summersale11_2026'
            || $Artikel->FunktionsAttribute.fkt_aktion == 'summersale15_2026'}
            {assign var=ssHeute value=$smarty.now|date_format:'%Y%m%d'}
            {if $ssHeute >= '20260727' && $ssHeute <= '20260809'}
                {assign var=summerSaleHideSaleRibbon value=true}
            {/if}
        {/if}
    {/if}

    {block name='snippets-ribbon-main'}
        {if isset($Artikel->oSuchspecialBild)}
            {if $summerSaleHideSaleRibbon && $Artikel->oSuchspecialBild->getType() == 2}
                {* SALE durch Summer-Sale-Badge ersetzt *}
            {elseif $Artikel->oSuchspecialBild->getType() === $smarty.const.SEARCHSPECIALS_CUSTOMBADGE}
                {assign var=customBadge value=$Artikel->oSuchspecialBild->getCssAndText()}
                <div class="ribbon ribbon-custom productbox-ribbon{if $customBadge->class !== ''}{$customBadge->class}{/if}"
                    {if $customBadge->style !== ''} style="{$customBadge->style}"{/if}>
                    {block name='snippets-ribbon-content'}
                        {$customBadge->text}
                    {/block}
                </div>
            {else}
                <div class="ribbon
                ribbon-{$Artikel->oSuchspecialBild->getType()} productbox-ribbon">
                    {block name='snippets-ribbon-content'}
                        {lang key='ribbon-'|cat:$Artikel->oSuchspecialBild->getType() section='productOverview' printf=$sale|default:''|cat:'%'}
                    {/block}
                </div>
            {/if}
        {/if}
    {/block}
{/block}
