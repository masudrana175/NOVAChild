{*
  Einheitliche Checkout-Aktionen.
  Parameter:
    $opcPrimary     Button-Text
    $opcBackHref    Zurück-Link
    $opcBackLabel   optional, Standard „Zurück“
    $opcShowTrust   optional, Trust-Zeile (nur Bestell-Schritt)
    $opcSubmitId    optional, z. B. complete-order-button
*}
{if !isset($opcBackLabel) || $opcBackLabel == ''}
    {$opcBackLabel = 'Zurück'}
{/if}
<div class="beautek-opc-actions{if $opcShowTrust|default:false}{else} beautek-opc-actions--sticky{/if}">
    <button type="submit"
            value="1"
            class="btn btn-primary btn-block submit_once beautek-opc-submit"
            {if $opcSubmitId|default:'' != ''}id="{$opcSubmitId|escape:'html'}"{/if}>
        {$opcPrimary}
    </button>
    <a href="{$opcBackHref}" class="beautek-opc-backlink">{$opcBackLabel}</a>
</div>
{if $opcShowTrust|default:false}
    {include file='checkout/inc_opc_trust.tpl'}
{/if}
