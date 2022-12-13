public without sharing class PageLayoutRetriever {
    public static List<Metadata.Metadata> getPageLayout(List<String> pageLayoutList) {
        return Metadata.Operations.retrieve(Metadata.MetadataType.Layout, pageLayoutList);
    }
}
