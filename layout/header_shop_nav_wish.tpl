{extends file="{$parent_template_path}/layout/header_shop_nav_wish.tpl"}

{block name='layout-header-shop-nav-wish-link'}
    {link class='nav-link' aria=['expanded' => 'false', 'label' => {lang key='wishlist'}] data=['toggle' => 'dropdown']}
        {literal}
            <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" width="18.28" height="16.44" viewBox="0 0 22.85 20.55"><g><path d="M15.72,0c-1.57,0-3.06,.5-4.29,1.43-1.23-.93-2.72-1.43-4.29-1.43C3.2,0,0,3.2,0,7.13c0,1.57,.5,3.05,1.44,4.29,.03,.04,.07,.08,.11,.12l9.13,8.73c.19,.19,.44,.28,.69,.28s.49-.09,.68-.27l9.01-8.45h.01c1.14-1.29,1.77-2.96,1.77-4.69,0-3.93-3.2-7.13-7.13-7.13Zm4.01,10.34l-8.35,7.84L2.99,10.15c-.65-.88-.99-1.92-.99-3.02,0-2.83,2.3-5.13,5.13-5.13,1.35,0,2.63,.52,3.59,1.46,.39,.38,1.01,.38,1.4,0,.97-.95,2.24-1.47,3.59-1.47,2.83,0,5.13,2.3,5.13,5.13,0,1.17-.4,2.3-1.12,3.2Z"/></g></svg>
        {/literal}
            
        <i class="fas fa-heart">
            <span id="badge-wl-count" class="fa-sup {if $wlCount === 0} d-none{/if}" title="{$wlCount}">
                {$wlCount}
            </span>
        </i>
    {/link}
{/block}

