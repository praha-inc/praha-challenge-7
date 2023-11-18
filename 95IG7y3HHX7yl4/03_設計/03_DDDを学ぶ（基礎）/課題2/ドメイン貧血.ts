namespace ドメイン貧血 {
  // ドメイン
  class Production {
    public id: string
    public constructor(id: string) {
      this.id = id
    }
  }

  // アプリケーションサービス層
  class Usecase1 {
    do(p: Production) {
      if (p.id.startsWith('aa')) {
        // aaから始まるカテゴリーのプロダクトならOK!
      }
    }
  }
  class Usecase2 {
    do(p: Production) {
      if (p.id.startsWith('bb')) {
        // bbから始まるカテゴリーのプロダクトならOK!
      }
    }
  }
}