<?php declare(strict_types=1);

namespace Template\NOVAChild;

/**
 * Class Bootstrap
 * @package Template\NOVAChild
 */
class Bootstrap extends \Template\NOVA\Bootstrap
{
    /**
     * @inheritdoc
     */
    protected function registerPlugins(): void
    {
        parent::registerPlugins();

        // Eigener, robuster Preis-Formatierer für berechnete Summen
        // (z. B. Artikel + ermittelter Versand) im Warenkorb.
        try {
            $smarty = $this->getSmarty();
            if ($smarty !== null) {
                $smarty->registerPlugin(\Smarty::PLUGIN_MODIFIER, 'beautekPrice', [$this, 'beautekFormatPrice']);
            }
        } catch (\Throwable $e) {
            // Absichtlich leer – darf den Shop niemals abbrechen.
        }
    }

    /**
     * Formatiert einen rohen Betrag als lokalisierten Preis-String.
     * Nutzt JTLs eigene Formatierung (korrekte Tausender-/Dezimaltrennung + Währung).
     *
     * @param mixed $amount
     * @return string
     */
    public function beautekFormatPrice($amount): string
    {
        try {
            $value = (float)$amount;
            if (\function_exists('gibPreisStringLocalized')) {
                return (string)\gibPreisStringLocalized($value);
            }

            return \number_format($value, 2, ',', '.') . ' €';
        } catch (\Throwable $e) {
            return (string)$amount;
        }
    }
}
