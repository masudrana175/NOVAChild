{block name='snippets-checkbox-checkbox'}
    {if $cb->identifier!=='RightOfWithdrawalOfDownloadItems' || ($cb->identifier==='RightOfWithdrawalOfDownloadItems' && (isset($hasDownloads) && $hasDownloads === true))}
        {checkbox
            id="{if isset($cIDPrefix)}{$cIDPrefix}_{/if}{$cb->cID}"
            name={$cb->cID}
            required=$cb->nPflicht === 1
            checked=$cb->isActive
        }
            {if !empty($cb->cLinkURL)}
                <a href="{$cb->cLinkURL}" class="popup checkbox-popup">
            {/if}
                {nl2br($cb->cName)}
            {if !empty($cb->cLinkURL)}
                </a>
            {/if}
            {if empty($cb->nPflicht)}
                {block name='snippets-checkbox-checkbox-optional'}
                    <span class='optional'> - {lang key='optional'}</span>
                {/block}
            {/if}
        {/checkbox}
    {/if}
{/block}