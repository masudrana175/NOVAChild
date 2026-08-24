{* Setzt $beautekOpc global (GET gewinnt, sonst Cookie bzw. bereits übergeben). *}
{if isset($smarty.get.opc)}
    {if $smarty.get.opc === 'beautek-opc-2026'}
        {assign var='beautekOpc' value=true scope='global'}
    {else}
        {assign var='beautekOpc' value=false scope='global'}
    {/if}
{elseif isset($smarty.cookies.beautek_opc) && $smarty.cookies.beautek_opc == '1'}
    {assign var='beautekOpc' value=true scope='global'}
{elseif !isset($beautekOpc)}
    {assign var='beautekOpc' value=false scope='global'}
{/if}
