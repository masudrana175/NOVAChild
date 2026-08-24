{extends file="{$parent_template_path}/basket/cart_dropdown.tpl"}

{block name='basket-cart-dropdown-cart-items'}
    {get_static_route id='warenkorb.php' assign='cartURL'}
    {form id="cart-sidebar-form" method="post" action=$cartURL class="jtl-validate" novalidate=true}
        {input type="hidden" name="wka" value="1"}
        {$smarty.block.parent}
    {/form}
{/block}

{block name='basket-cart-dropdown-buttons'}
    {row class="cart-dropdown-buttons"}
        {col cols=12}
            <button type="button"
                class="btn btn-outline-primary btn-sm btn-block cart-dropdown-continue cart-sidebar-continue"
                aria-label="{lang key='continueShopping' section='checkout'}">
                <i class="fa fa-arrow-circle-left" aria-hidden="true"></i>
                {lang key='continueShopping' section='checkout'}
            </button>
        {/col}
        {col cols=12}
            {button variant="primary"
                type="link"
                block=true
                size="sm"
                title="{lang key='gotoBasket'}"
                href="{get_static_route id='warenkorb.php'}"
                class="cart-dropdown-cart"}
                {lang key='gotoBasket'}
            {/button}
        {/col}
    {/row}
{/block}

{* Komplette Summenübersicht (Zwischensumme/USt.) in der Sidebar ausblenden *}
{block name='basket-cart-dropdown-total'}{/block}

{block name='basket-cart-dropdown-cart-item'}
    {foreach $cartPositions as $oPosition}
        {if $oPosition@iteration > $maxCartPositions}
            {break}
        {/if}
        {if !$oPosition->istKonfigKind()}
            {if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL
            || $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
                <tr class="cart-sidebar-item">
                    <td class="cart-sidebar-item-cell" colspan="2">
                        <div class="cart-sidebar-item-head">
                            <div class="cart-sidebar-item-media">
                                {if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL && !empty($oPosition->Artikel->cURLFull)}
                                    {link href=$oPosition->Artikel->cURLFull title=$oPosition->cName|transByISO|escape:'html'}
                                        {include file='snippets/image.tpl'
                                            fluid=false
                                            item=$oPosition->Artikel
                                            square=false
                                            srcSize='xs'
                                            sizes='64px'
                                            class='img-sm'}
                                    {/link}
                                {elseif !empty($oPosition->Artikel->cVorschaubildURL)}
                                    {include file='snippets/image.tpl'
                                        fluid=false
                                        item=$oPosition->Artikel
                                        square=false
                                        srcSize='xs'
                                        sizes='64px'
                                        class='img-sm'}
                                {/if}
                            </div>
                            <div class="cart-sidebar-item-copy">
                                <div class="cart-sidebar-item-title">
                                    {if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL && !empty($oPosition->Artikel->cURLFull)}
                                        {link href=$oPosition->Artikel->cURLFull title=$oPosition->cName|transByISO|escape:'html'}
                                            {$oPosition->cName|transByISO}
                                        {/link}
                                    {else}
                                        {$oPosition->cName|transByISO}
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="cart-sidebar-item-actions">
                            {if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
                                {if $oPosition->istKonfigVater()}
                                    <div class="cart-sidebar-qty cart-sidebar-qty--static">
                                        {lang key="quantity" section="checkout"}: {$oPosition->nAnzahl|replace_delim}
                                        {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                                    </div>
                                    {link class="btn btn-outline-secondary btn-sm btn-block cart-sidebar-configure"
                                        href="{$ShopURL}/?a={$oPosition->kArtikel}&ek={$oPosition@index}"}
                                        <i class="fa fa-cogs icon-mr-2"></i>{lang key='configure'}
                                    {/link}
                                {else}
                                    {if $oPosition->Artikel->fMindestbestellmenge}
                                        {assign var=mindestbestellmenge value=$oPosition->Artikel->fMindestbestellmenge}
                                    {else}
                                        {assign var=mindestbestellmenge value=0}
                                    {/if}
                                    <div class="cart-sidebar-qty">
                                        {inputgroup id="cart-sidebar-qty-{$oPosition@index}" class="form-counter choose_quantity"}
                                            {inputgroupprepend}
                                                {button variant="" class="btn-decrement cart-sidebar-qty-btn"
                                                    type="button"
                                                    data=["sidebar-count-down"=>""]
                                                    aria=["label"=>{lang key='decreaseQuantity' section='aria'}]}
                                                    <span class="fas fa-minus"></span>
                                                {/button}
                                            {/inputgroupprepend}
                                            {input type="number"
                                                min="{$mindestbestellmenge}"
                                                max=$oPosition->Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''
                                                required=($oPosition->Artikel->fAbnahmeintervall > 0)
                                                step="{if $oPosition->Artikel->cTeilbar === 'Y' && $oPosition->Artikel->fAbnahmeintervall == 0}any{elseif $oPosition->Artikel->fAbnahmeintervall > 0}{$oPosition->Artikel->fAbnahmeintervall}{else}1{/if}"
                                                id="cart-sidebar-quantity-{$oPosition@index}"
                                                class="quantity"
                                                name="anzahl[{$oPosition@index}]"
                                                aria=["label"=>"{lang key='quantity'}"]
                                                value=$oPosition->nAnzahl
                                                data=[
                                                    "decimals"=>{getDecimalLength quantity=$oPosition->Artikel->fAbnahmeintervall},
                                                    "product-id"=>"{if isset($oPosition->Artikel->kVariKindArtikel)}{$oPosition->Artikel->kVariKindArtikel}{else}{$oPosition->Artikel->kArtikel}{/if}"
                                                ]
                                            }
                                            {inputgroupappend}
                                                {button variant="" class="btn-increment cart-sidebar-qty-btn"
                                                    type="button"
                                                    data=["sidebar-count-up"=>""]
                                                    aria=["label"=>{lang key='increaseQuantity' section='aria'}]}
                                                    <span class="fas fa-plus"></span>
                                                {/button}
                                            {/inputgroupappend}
                                        {/inputgroup}
                                    </div>
                                {/if}
                            {elseif $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                {input name="anzahl[{$oPosition@index}]" type="hidden" value="1"}
                                <div class="cart-sidebar-qty cart-sidebar-qty--static">
                                    {lang key="quantity" section="checkout"}: 1
                                </div>
                            {/if}
                            {button type="submit"
                                variant="link"
                                size="sm"
                                class="cart-sidebar-delete droppos"
                                name="dropPos"
                                value=$oPosition@index
                                title="{lang key='delete'}"
                                aria=["label"=>"{lang key='delete'}"]}
                                <span class="fas fa-trash-alt cart-sidebar-delete-icon" aria-hidden="true"></span>
                            {/button}
                        </div>
                        <div class="cart-sidebar-line-total">
                            <span class="cart-sidebar-line-total-label">Summe</span>
                            <span class="cart-sidebar-line-total-price">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </span>
                        </div>
                    </td>
                </tr>
            {else}
                <tr class="cart-sidebar-item cart-sidebar-item--meta">
                    <td class="cart-sidebar-item-cell" colspan="2">
                        <div class="cart-sidebar-item-head cart-sidebar-item-head--meta">
                            <div class="cart-sidebar-item-copy">
                                <div class="cart-sidebar-item-title">
                                    {$oPosition->cName|transByISO|escape:'htmlall'}
                                    {if $oPosition->nAnzahl > 1}
                                        <span class="cart-sidebar-meta-qty">({$oPosition->nAnzahl|replace_delim}x)</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="cart-sidebar-line-total">
                            <span class="cart-sidebar-line-total-label">Summe</span>
                            <span class="cart-sidebar-line-total-price">
                                {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            </span>
                        </div>
                    </td>
                </tr>
            {/if}
        {/if}
    {/foreach}
{/block}
