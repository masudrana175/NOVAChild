{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc}
    {assign var=step1_active value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
    {assign var=step2_active value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
    {assign var=step3_active value=($bestellschritt[5] == 1)}
    {if $bestellschritt[1] != 3}
        <nav class="beautek-opc-progress" aria-label="{lang key='secureCheckout' section='checkout'}">
            {link href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1"
                class="beautek-opc-progress__item{if $step1_active} is-current{/if}{if $step2_active || $step3_active} is-done{/if}"}
                <span class="beautek-opc-progress__num">1</span>
                <span class="beautek-opc-progress__label">Adresse</span>
            {/link}
            <span class="beautek-opc-progress__sep" aria-hidden="true"></span>
            {link href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                class="beautek-opc-progress__item{if $step2_active} is-current{/if}{if $step3_active} is-done{/if}"}
                <span class="beautek-opc-progress__num">2</span>
                <span class="beautek-opc-progress__label">Zahlung</span>
            {/link}
            <span class="beautek-opc-progress__sep" aria-hidden="true"></span>
            <span class="beautek-opc-progress__item{if $step3_active} is-current{/if}">
                <span class="beautek-opc-progress__num">3</span>
                <span class="beautek-opc-progress__label">Bestellen</span>
            </span>
        </nav>
    {/if}
{else}
    {include file="{$parent_template_path}/checkout/inc_steps.tpl"}
{/if}
