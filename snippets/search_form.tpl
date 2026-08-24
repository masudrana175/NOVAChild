{block name='snippets-search-form'}
<div class="search-form-phone-wrapper">
    <div class="search-wrapper" style="max-width: calc(100% - 46px - 1rem);">
        {form action="{$ShopURL}/" method='get' class='main-search flex-grow-1' slide=true}
            {inputgroup}
                {input id="{$id}" name="qs" type="text" class="ac_input" placeholder="{lang key='search'}" autocomplete="off" aria=["label"=>"{lang key='search'}"]}
                {inputgroupaddon append=true}
                    {button type="submit" name="search" variant="secondary" aria=["label"=>{lang key='search'}]}
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 21.94 20.34" width="17.552" height="16.272" fill="white"><g><path d="M21.94,18.81l-5.71-4.82c1-1.44,1.6-3.19,1.6-5.08C17.83,4,13.83,0,8.92,0S0,4,0,8.92s4,8.92,8.92,8.92c2.31,0,4.41-.89,5.99-2.33l5.74,4.84,1.29-1.53ZM2,8.92c0-3.81,3.1-6.92,6.92-6.92s6.92,3.1,6.92,6.92-3.1,6.92-6.92,6.92-6.92-3.1-6.92-6.92Z"/></g></svg>
                    {/button}
                {/inputgroupaddon}
                <span class="form-clear d-none"><i class="fas fa-times"></i></span>
            {/inputgroup}
        {/form}
    </div>
     <div class="phone-button">
                                                <a href="tel:+492713137430">
                                                        <svg width="20" height="20" fill="currentColor" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 90.7 90.7" style="enable-background:new 0 0 90.7 90.7;" xml:space="preserve">
                                                        <path d="M73,16.7c-0.7-2.9-2.2-5.4-4.5-7.2c-1-0.8-2.3-1.1-3.6-1c-1.3,0.2-2.4,0.8-3.2,1.9L47.5,28.9
                                                        c-1.6,2.1-1.2,5.2,0.9,6.8c2.2,1.7,4.8,2.5,7.7,2.5c1,0,2.1-0.2,3.1-0.4c-1.7,3.6-4.2,7.9-7.9,12.8c-3.8,5-7.4,8.7-10.5,11.3
                                                        c-0.2-4-1.9-7.5-4.9-9.8c-2.1-1.6-5.2-1.2-6.8,0.9L14.9,71.6c-1.6,2.1-1.2,5.2,0.9,6.8c2.2,1.7,4.8,2.5,7.7,2.5
                                                        c0.4,0,0.8-0.1,1.1-0.1c1.4,0.8,3.3,1.5,5.9,1.5c3.2,0,7.3-1,12.5-4.2c6.7-4,13.7-10.6,19.8-18.6c6.1-8,10.6-16.5,12.7-24
                                                        C78.7,24.4,75.6,19.1,73,16.7z"></path>
                                                        </svg>
                                                    
                                                </a>
                                            </div>
    </div>
{/block}

{* removed w-100-util class from search-wrapper for phone button utility *}