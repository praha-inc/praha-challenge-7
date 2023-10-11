/// Utils 
class DateUtils {
  static getOneYearAgo(date: Date): Date {
    const oneYearAgo = new Date(date);
    oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);
    return oneYearAgo;
  }
}



/// Entities
interface User {
  readonly userId: string;
}

/// 購入者Entity
class Purchaser implements User {
  readonly userId: string;

  constructor(userId: string) {
    this.userId = userId;
  }
}

/// 商品Entity
class Product {
  constructor(
    readonly productId: string
  ) {}

  equals(otherProduct: Product): boolean {
    return this.productId === otherProduct.productId;
  }
}

class PurchaseItem extends Product {
  constructor(
    readonly productId: string
  ) {
    super(productId);
  }
  
  equals(otherProduct: Product): boolean {
    return super.equals(otherProduct);
  }
}

/// 購入履歴Entity
interface PurchaseTransaction {
  readonly succeeded: boolean;
  readonly completedAt: Date;
}

class Purchase {
  constructor(
    readonly purchaser: Purchaser,
    readonly product: Product,
    readonly transaction: PurchaseTransaction
  ) {}
}

class Purchases {
  private purchases: Purchase[];

  constructor(purchases: Purchase[]) {
    this.purchases = purchases;
  }

  get all(): Purchase[] {
    return this.purchases;
  }
}



/// Repositories
interface IPurchaseRepo {
  getPurchasesByUser: (user: User) => Promise<Purchases>;
}



/// ValidationRule
interface PurchaseValidationRule {
  isInvalid(cartItems: PurchaseItem): boolean;
}

class HasPurchasedWithinLastYearRule implements PurchaseValidationRule {
  private purchases: Purchases;

  constructor(purchases: Purchases) {
    this.purchases = purchases;
  }

  isInvalid(purchaseItem: PurchaseItem): boolean {
    const oneYearAgo = DateUtils.getOneYearAgo(new Date());
    return this.purchases.all.some(
        purchase =>
          purchase.product.equals(purchaseItem) &&
          purchase.transaction.succeeded &&
          purchase.transaction.completedAt > oneYearAgo
      );
  }
}




/// Services
class PurchaseService {
  private purchaseRepo: IPurchaseRepo; // 不要ですが、購入処理を想定して残しています
  private purchaseItem: PurchaseItem;
  private validationRules: PurchaseValidationRule[]; 

  public constructor(purchaseRepo: IPurchaseRepo, cartItems: PurchaseItem, validationRules: PurchaseValidationRule[]) {
    this.purchaseRepo = purchaseRepo;
    this.purchaseItem = cartItems;
    this.validationRules = validationRules;
  }

  public async purchase() {
    for (const rule of this.validationRules) {
      if (rule.isInvalid(this.purchaseItem)) {
        throw new Error('購入条件を満たしていません！');
      }
    }

    // 購入手続きに進む　省略
  }
}

