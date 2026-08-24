{extends file="{$parent_template_path}/basket/cart_dropdown_label.tpl"}

{* data-display=static: kein Popper – verhindert Blinken bei Hover auf Links/Buttons *}
{block name='basket-cart-dropdown-label-link'}
    {link class='nav-link'
        aria=['expanded' => 'false', 'label' => {lang key='basket'}]
        data=['toggle' => 'dropdown', 'display' => 'static']}
        <i class='fas fa-shopping-cart cart-icon-dropdown-icon'>
            <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" width="17.424" height="18.688" viewBox="0 0 21.78 23.36"><g><path d="M20.78,6.64h-3.1c-.28-3.71-3.21-6.64-6.78-6.64S4.39,2.93,4.1,6.64H1c-.55,0-1,.45-1,1v12.17c0,1.96,1.59,3.55,3.55,3.55h14.67c1.96,0,3.55-1.59,3.55-3.55V7.64c0-.55-.45-1-1-1ZM10.89,2c2.47,0,4.49,2.04,4.76,4.64H6.13c.27-2.6,2.29-4.64,4.76-4.64Zm8.89,17.81c0,.86-.7,1.55-1.55,1.55H3.55c-.86,0-1.55-.7-1.55-1.55V8.64H19.78v11.17Z"/></g></svg>
            {if $WarenkorbArtikelPositionenanzahl >= 1}
                <span class="fa-sup" title="{$WarenkorbArtikelPositionenanzahl}">
                    {$WarenkorbArtikelPositionenanzahl}
                </span>
            {/if}
        </i>
    {/link}
{/block}

{block name='basket-cart-dropdown-labelprice'}
{/block}
