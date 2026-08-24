{* Rechnungsdaten unverändert mitsenden, wenn nur die Lieferadresse bearbeitet wird. *}
{if isset($Kunde)}
    {input type="hidden" name="anrede" value=$Kunde->cAnrede|default:''}
    {input type="hidden" name="titel" value=$Kunde->cTitel|default:''}
    {input type="hidden" name="vorname" value=$Kunde->cVorname|default:''}
    {input type="hidden" name="nachname" value=$Kunde->cNachname|default:''}
    {input type="hidden" name="firma" value=$Kunde->cFirma|default:''}
    {input type="hidden" name="firmazusatz" value=$Kunde->cZusatz|default:''}
    {input type="hidden" name="strasse" value=$Kunde->cStrasse|default:''}
    {input type="hidden" name="hausnummer" value=$Kunde->cHausnummer|default:''}
    {input type="hidden" name="adresszusatz" value=$Kunde->cAdressZusatz|default:''}
    {input type="hidden" name="land" value=$Kunde->cLand|default:''}
    {input type="hidden" name="bundesland" value=$Kunde->cBundesland|default:''}
    {input type="hidden" name="plz" value=$Kunde->cPLZ|default:''}
    {input type="hidden" name="ort" value=$Kunde->cOrt|default:''}
    {input type="hidden" name="ustid" value=$Kunde->cUSTID|default:''}
    {input type="hidden" name="email" value=$Kunde->cMail|default:''}
    {input type="hidden" name="tel" value=$Kunde->cTel|default:''}
    {input type="hidden" name="fax" value=$Kunde->cFax|default:''}
    {input type="hidden" name="mobil" value=$Kunde->cMobil|default:''}
    {input type="hidden" name="www" value=$Kunde->cWWW|default:''}
    {if !empty($Kunde->dGeburtstag_formatted)}
        {input type="hidden" name="geburtstag" value=$Kunde->dGeburtstag_formatted|date_format:'Y-m-d'}
    {/if}
{/if}
