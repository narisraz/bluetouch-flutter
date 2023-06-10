enum ClientCategory {
  private, borneFontaine, social
}

class ClientCategoryData {
  final String label;

  ClientCategoryData(this.label);
}

extension ClientCategoryExtension on ClientCategory {
  ClientCategoryData get data {
    switch (this) {
      case ClientCategory.private:
        return ClientCategoryData("Privée");
      case ClientCategory.borneFontaine:
        return ClientCategoryData("Borne fontaine");
      case ClientCategory.social:
        return ClientCategoryData("Social");
    }
  }
}