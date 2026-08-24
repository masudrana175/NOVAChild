<aside class="beautek-opc__aside" aria-label="{lang key='orderOverview' section='account data'}">
    <div class="beautek-opc-card beautek-opc-summary">
        <div class="beautek-opc-card__head">
            <span class="beautek-opc-card__title">{lang key='orderOverview' section='account data'}</span>
            {link href="{get_static_route id='warenkorb.php'}" class="beautek-opc-card__edit"}
                {lang key='change'}
            {/link}
        </div>
        <div class="beautek-opc-card__body">
            <ul class="beautek-opc-lines">
                {foreach JTL\Session\Frontend::getCart()->PositionenArr as $oPosition}
                    {if !$oPosition->istKonfigKind()}
                        <li class="beautek-opc-line type-{$oPosition->nPosTyp}">
                            <div class="beautek-opc-line__media">
                                {if ($oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL
                                    || $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK)
                                    && !empty($oPosition->Artikel->cVorschaubildURL)}
                                    {include file='snippets/image.tpl' item=$oPosition->Artikel square=true srcSize='sm'}
                                {else}
                                    <span class="beautek-opc-line__placeholder" aria-hidden="true"></span>
                                {/if}
                                {if $oPosition->nAnzahl > 1}
                                    <span class="beautek-opc-line__qty">{$oPosition->nAnzahl|replace_delim}</span>
                                {/if}
                            </div>
                            <div class="beautek-opc-line__info">
                                <span class="beautek-opc-line__name">{$oPosition->cName|transByISO}</span>
                                {if $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL
                                    && $oPosition->nAnzahl > 0}
                                    <span class="beautek-opc-line__meta">
                                        {$oPosition->nAnzahl|replace_delim}
                                        {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{else}×{/if}
                                        {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                    </span>
                                {/if}
                            </div>
                            <div class="beautek-opc-line__price">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </div>
                        </li>
                    {/if}
                {/foreach}
            </ul>

            <div class="beautek-opc-totals">
                {if $NettoPreise}
                    <div class="beautek-opc-totals__row">
                        <span>{lang key='totalSum'} ({lang key='net'})</span>
                        <span>{$WarensummeLocalized[$NettoPreise]}</span>
                    </div>
                {/if}
                {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|count > 0}
                    {foreach $Steuerpositionen as $Steuerposition}
                        <div class="beautek-opc-totals__row">
                            <span>{$Steuerposition->cName}</span>
                            <span>{$Steuerposition->cPreisLocalized}</span>
                        </div>
                    {/foreach}
                {/if}
                {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                    <div class="beautek-opc-totals__row">
                        <span>{lang key='useCredit' section='account data'}</span>
                        <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
                    </div>
                {/if}
                <div class="beautek-opc-totals__row beautek-opc-totals__row--grand">
                    <span>{lang key='totalSum'}</span>
                    <span>{$WarensummeLocalized[0]}</span>
                </div>
            </div>

            {if $beautekOpcShowOrderButton|default:false}
                <div class="beautek-opc-summary__cta">
                    <button type="submit"
                            form="complete_order"
                            class="btn btn-primary btn-block submit_once beautek-opc-submit"
                            name="abschluss"
                            value="1">
                        {lang key='orderLiableToPay' section='checkout'}
                    </button>
                </div>
            {/if}

            {if $beautekOpcShowCoupon|default:false && $KuponMoeglich|default:0 == 1}
                <div class="beautek-opc-coupon">
                    {include file='checkout/coupon_form.tpl'}
                </div>
            {/if}
        </div>
    </div>
</aside>
