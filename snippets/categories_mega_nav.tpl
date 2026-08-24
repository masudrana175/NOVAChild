{* desktop navigation (> screen-min-sm) *}
{strip}
    {block name="category-nav-megamenu"}
    <!-- Categories Mega Nav -->

        {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
            {* <pre>{$startId|var_dump}</pre> *}
        {/if}

        {get_category_array categoryId=0 assign='categoriesFirstLayerTemp'}
         {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
            {* <pre>{$categoriesFirstLayerTemp|var_dump}</pre> *}
        {/if}

        {foreach name="categoriesFirstLayerTemp" from=$categoriesFirstLayerTemp item='categoryTemp'}

        {assign var="subcategories" value=$categoryTemp->getChildren()}

        {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
            {* <pre>{$subcategories|var_dump}</pre> *}
        {/if}

            {if !isset($activeIdFirstLayer)}
                {if isset($NaviFilter->Kategorie) && intval($NaviFilter->Kategorie->kKategorie) > 0}
                    {$activeIdFirstLayer = $NaviFilter->Kategorie->kKategorie}
                {elseif $nSeitenTyp == 1 && isset($Artikel)}
                    {assign var='activeIdFirstLayer' value=$Artikel->gibKategorie()}
                {elseif $nSeitenTyp == 1 && isset($smarty.session.LetzteKategorie)}
                    {$activeIdFirstLayer = $smarty.session.LetzteKategorie}
                {else}
                    {$activeIdFirstLayer = 0}
                {/if}
            {/if}
            {if !isset($activeParentsFirstLayer) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
                {get_category_parents categoryId=$activeIdFirstLayer assign='activeParentsFirstLayer'}
            {/if}

            {* {if $categoryTemp->cKurzbezeichnung == 'Men' || $categoryTemp->cKurzbezeichnung == 'Women' || $categoryTemp->cKurzbezeichnung == 'Kids'} *}
            {if $categoryTemp->parentID === 0}

            {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
                {* <pre>{$categoryTemp->kKategorie|var_dump}</pre> *}
            {/if}
                <ul class="navbar-nav  {if $categoryTemp->kKategorie == $activeIdFirstLayer || (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie == $categoryTemp->kKategorie) || $activeIdFirstLayer == 0 &&  $categoryTemp->cKurzbezeichnung == 'Men' } show{/if}" data-id="{$categoryTemp->kKategorie}">
                    {* {include file='snippets/categories_mega.tpl' startId=$categoryTemp->kKategorie} *}
                    {include file='snippets/categories_mega.tpl' startId=$categoryTemp->kKategorie categories=$subcategories}
                </ul>
            {/if}

        {/foreach}
    {/block}
{/strip}
