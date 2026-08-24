{block name='layout-header-nav-search'}
    {block name='layout-header-nav-search-search'}
        <{$tag|default:'div'} class="nav-item" id="search">
            <div class="search-wrapper">
                {* action muss Shop-Root sein – /search/ existiert nicht; relative Artikel-Links würden sonst unter /search/ landen *}
                <form action="{$ShopURL}/" method="get" role="search">
                    <div class="form-icon">
                        {inputgroup}
                            {input id="search-header" name="qs" type="text" class="ac_input" placeholder="Wonach suchst du?" autocomplete="off" aria=["label"=>"{lang key='search'}"]}
                            {inputgroupaddon append=true}
                                {button type="submit" name="search" variant="secondary" aria=["label"=>{lang key='search'}]}
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 21.94 20.34" width="17.552" height="16.272" fill="white"><g><path d="M21.94,18.81l-5.71-4.82c1-1.44,1.6-3.19,1.6-5.08C17.83,4,13.83,0,8.92,0S0,4,0,8.92s4,8.92,8.92,8.92c2.31,0,4.41-.89,5.99-2.33l5.74,4.84,1.29-1.53ZM2,8.92c0-3.81,3.1-6.92,6.92-6.92s6.92,3.1,6.92,6.92-3.1,6.92-6.92,6.92-6.92-3.1-6.92-6.92Z"/></g></svg>
                                {/button}
                            {/inputgroupaddon}
                            <span class="form-clear d-none" aria-label="{lang key='clearSearch'}" title="{lang key='clearSearch'}"><i class="fas fa-times" aria-hidden="true" role="img" aria-label="{lang key='clearSearch'}"></i></span>
                        {/inputgroup}
                    </div>
                </form>
            </div>
        </{$tag|default:'div'}>
    {/block}
    {block name='layout-header-nav-search-search-dropdown'}
        {if $Einstellungen.template.header.mobile_search_type === 'dropdown'}
			{$navIcon="<i id='mobile-search-dropdown' class='fas fa-search' aria-hidden='true' role='img' aria-label='{lang key='search'}' title='{lang key='search'}'></i>"}
            {navitemdropdown tag='div' class='search-wrapper-dropdown d-block d-lg-none'
                text=$navIcon
                right=true
                no-caret=true
                router-aria=['label'=>{lang key='findProduct'}]}
                <div class="dropdown-body" role="search" aria-label="{lang key='findProduct'}" title="{lang key='findProduct'}">
                    {include file='snippets/search_form.tpl' id='search-header-desktop'}
                </div>
            {/navitemdropdown}
        {/if}
    {/block}
{/block}
