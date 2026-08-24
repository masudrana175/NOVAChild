{block name='layout-header-nav-icons'}
    {nav id="shop-nav" right=true class="nav-right order-lg-last nav-icons"}
        {block name='layout-header-nav-icons-include-header-nav-search'}
            {if $Einstellungen.template.header.menu_single_row !== 'Y'}
                {include file='layout/header_nav_search.tpl' tag='li'}
            {/if}
        {/block}
        {block name='layout-header-nav-icons-include-header-kontakt'}
            <li class="nav-item kontakt">
                <a class="nav-link         " title="" target="_self" href="https://www.beautek.de/Kontakt_1">
                    {if !empty({lang key="mainbar_contact-us" section="custom"})} {lang key="mainbar_contact-us" section="custom"} {/if}
                </a>
            </li>
        {/block}
        {block name='layout-header-nav-icons-include-header-ausstellung'}
            <li class="nav-item ausstellung">
                <a class="nav-link" title="Unsere Großhandelsaustellung. Europaweit eine Top Vielfalt." target="_self" href="https://www.beautek.de/kosmetik-medizin-friseur-ausstellung-in-nrw">
                    {if !empty({lang key="mainbar_ausstellung" section="custom"})} {lang key="mainbar_ausstellung" section="custom"} {/if}
                </a>
            </li>
        {/block}
        
        {block name='layout-header-nav-icons-include-currency-dropdown'}
            {if $Einstellungen.template.header.menu_show_topbar === 'N' && !$isMobile}
                {include file='snippets/currency_dropdown.tpl'}
            {/if}
        {/block}
        
        {block name='layout-header-nav-icons-include-header-shop-nav-account'}
            {include file='layout/header_shop_nav_account.tpl'}
        {/block}
        {if !($isMobile)}
            {if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
                {block name='layout-header-nav-icons-include-header-shop-nav-compare'}
                    {include file='layout/header_shop_nav_compare.tpl'}
                {/block}
            {/if}
            {block name='layout-header-nav-icons-include-header-shop-nav-wish'}
                {include file='layout/header_shop_nav_wish.tpl'}
            {/block}
        {/if}
        {block name='layout-header-nav-icons-include-cart-dropdown-label'}
            {include file='basket/cart_dropdown_label.tpl'}
        {/block}
        {block name='layout-header-nav-icons-include-language-dropdown'}
            {include file='snippets/language_dropdown.tpl' dropdownClass="d-flex {if $Einstellungen.template.header.menu_show_topbar === 'Y'}d-block{/if}"}
        {/block}
    {/nav}
{/block}
