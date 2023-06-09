enum ClientCategory {
  PRIVATE, BORNE_FONTAINE, SOCIAL
}

class ClientCategoryData {
  final String label;

  ClientCategoryData(this.label);
}

extension ClientCategoryExtension on ClientCategory {
  ClientCategoryData get data {
    switch (this) {
      case ClientCategory.PRIVATE:
        return ClientCategoryData("Privée");
      case ClientCategory.BORNE_FONTAINE:
        return ClientCategoryData("Borne fontaine");
      case ClientCategory.SOCIAL:
        return ClientCategoryData("Social");
    }
  }
}