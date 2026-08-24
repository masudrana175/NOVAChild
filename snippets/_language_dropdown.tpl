{block name='snippets-language-dropdown'}
    {* {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1} *}

    
        {navitemdropdown
        class="language-dropdown {$dropdownClass|default:''}"
        right=true
        text="DE"
        }
            {* {foreach $smarty.session.Sprachen as $language} *}
                {block name='snippets-language-dropdown-item'}
                    {dropdownitem href="/"
                        class="link-lang"
                        data=["iso"=>"de"]
                        rel="nofollow"
                        }
                        DE
                    {/dropdownitem}
                {/block}
            {* {/foreach} *}
        {/navitemdropdown}
    {* {/if} *}
{/block}
