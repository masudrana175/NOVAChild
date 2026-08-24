{extends file="{$parent_template_path}/layout/header_shop_nav_compare.tpl"}

{block name='layout-header-shop-nav-compare-link'}
    {link class='nav-link' data=['toggle'=>'dropdown'] aria=['haspopup'=>'true', 'expanded'=>'false', 'label'=>{lang key='compare'}]}
        <i class="fas fa-list">

            <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" width="16.616" height="16.616" viewBox="0 0 20.77 20.77"><g><g><path d="M19.77,0H1C.45,0,0,.45,0,1V19.77c0,.55,.45,1,1,1H19.77c.55,0,1-.45,1-1V1c0-.55-.45-1-1-1Zm-1,18.77H2V2H18.77V18.77Z"/><rect x="8.21" y="4.15" width="8.55" height="2"/><rect x="8.21" y="9.38" width="8.55" height="2"/><rect x="8.21" y="14.62" width="8.55" height="2"/><rect x="4.08" y="4.15" width="2.25" height="2"/><rect x="4.08" y="9.38" width="2.25" height="2"/><rect x="4.08" y="14.62" width="2.25" height="2"/></g></g></svg>

            <span id="comparelist-badge" class="fa-sup" title="{if !empty($smarty.session.Vergleichsliste->oArtikel_arr)}{$smarty.session.Vergleichsliste->oArtikel_arr|count}{/if}">
                {if !empty($smarty.session.Vergleichsliste->oArtikel_arr)}{$smarty.session.Vergleichsliste->oArtikel_arr|count}{/if}
            </span>
        </i>
    {/link}
{/block}