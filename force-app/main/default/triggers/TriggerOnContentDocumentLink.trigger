trigger TriggerOnContentDocumentLink on ContentDocumentLink (after insert) {

    
    ContentDocumentLinkTrigClass.onAfterInser(trigger.new);
}