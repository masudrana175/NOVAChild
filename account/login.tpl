{extends file="{$parent_template_path}/account/login.tpl"}

{block name='account-login'}
<div class="login-page-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-7">
                {$smarty.block.parent}
            </div>
            <div class="col-12 col-lg-5">
                <div class="login-benefits-box">
                    <h3 class="benefits-title">Deine Vorteile bei BEAUTEK</h3>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                        </div>
                        <div class="benefit-content">
                            <h4>Schnelle Lieferung</h4>
                            <p>Expressversand verfügbar – heute bestellt, morgen bei dir.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </div>
                        <div class="benefit-content">
                            <h4>Exklusive Angebote für Kunden</h4>
                            <p>Profitiere von speziellen Rabatten und Aktionen nur für registrierte Kunden.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                        </div>
                        <div class="benefit-content">
                            <h4>BEAUTEK Business Club Mitgliedschaft</h4>
                            <p>Werde Teil unserer exklusiven Community mit besonderen Vorteilen.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                            </svg>
                        </div>
                        <div class="benefit-content">
                            <h4>Persönliche Beratung</h4>
                            <p>Unser Expertenteam steht dir jederzeit mit Rat und Tat zur Seite.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.login-page-wrapper {
    padding: 40px 0;
}

.login-benefits-box {
    background: linear-gradient(135deg, #2d3748 0%, #1a202c 100%);
    border-radius: 16px;
    padding: 40px 30px;
    color: #fff;
    height: 100%;
    box-shadow: 0 10px 40px rgba(0,0,0,0.15);
}

.benefits-title {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 30px;
    color: #fff;
    text-align: center;
    padding-bottom: 20px;
    border-bottom: 2px solid rgba(255,255,255,0.1);
}

.benefit-item {
    display: flex;
    align-items: flex-start;
    gap: 20px;
    padding: 20px 0;
    border-bottom: 1px solid rgba(255,255,255,0.08);
}

.benefit-item:last-child {
    border-bottom: none;
}

.benefit-icon {
    flex-shrink: 0;
    width: 50px;
    height: 50px;
    background: rgba(255,255,255,0.1);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8B1538;
}

.benefit-icon svg {
    stroke: #8B1538;
}

.benefit-content h4 {
    font-size: 1rem;
    font-weight: 600;
    margin: 0 0 8px 0;
    color: #fff;
}

.benefit-content p {
    font-size: 0.875rem;
    margin: 0;
    color: rgba(255,255,255,0.7);
    line-height: 1.5;
}

@media (max-width: 991px) {
    .login-benefits-box {
        margin-top: 30px;
    }
}
</style>
{/block}
