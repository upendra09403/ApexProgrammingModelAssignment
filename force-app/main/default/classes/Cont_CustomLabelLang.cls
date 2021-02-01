public class Cont_CustomLabelLang {
 
    public String language {get;set;}

    public PageReference toFrench() {
        language = 'fr';
        return null;
    }

    public PageReference toEnglish() {
        language = 'en_US';
        return null;
    }

    public Cont_CustomLabelLang() {
        toEnglish();
    }
}