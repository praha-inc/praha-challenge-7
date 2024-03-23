/**
  修正前
  interface Purchase {
    userId: string
    productId: string
    transaction: {
      succeeded: true
      completedAt: Date
    }
  }

  interface PaymentRecordRepo {
    getPurchasesBy: (userId: string) => Purchase[]
  }

  class PurchaseService {
    public constructor(private paymentRecordRepo: PaymentRecordRepo) {}

    public purchase(userId: string, productId: string) {
      const allPurchases = this.paymentRecordRepo.getPurchasesBy(userId)
      const pastPurchase = allPurchases.find((p) => p.productId === productId && p.transaction.succeeded)
      if (pastPurchase) {
        throw new Error('この商品はおひとりさま一品限定です！')
      }

      // 購入手続きに進む
    }
  }
*/

/**
 * 修正後
 */
interface Purchase {
    user: User
    product: Product
    transaction: PurchaseTransaction
    checkTransaction: () => boolean
    productEquals: (otherProduct: Product) => boolean
  }
  
  interface PurchaseTransaction {
    succeeded: Boolean
    completedAt: Date
  }
  
  interface User {
    id: string
    name: string
    equals: (user: User) => boolean
  }
  
  interface Product {
    id: string
    name: string
    equals: (product: Product) => boolean
  }
  
  interface SalesRuleValidator {
    validate: (user: User, product: Product) => ValidationResult
  }
  
  class SpecialItemSalesRuleValidator implements SalesRuleValidator{
    private readonly paymentRecordRepo :PaymentRecordRepo;
  
    constructor(paymentRecordRepo: PaymentRecordRepo){
      this.paymentRecordRepo = paymentRecordRepo;
    }
  
    public validate(user: User, product: Product){
      const allPurchases = this.paymentRecordRepo.getPurchasesBy(user);
      const pastPurchase = allPurchases.find(p => p.productEquals(product) && p.checkTransaction);
      if(pastPurchase){
        return new ValidationResult(true, 'この商品はおひとりさま一品限定です！');
      }
      return new ValidationResult();
    }
  } 
  
  interface PaymentRecordRepo {
    getPurchasesBy: (user: User) => Purchase[]
  }
  
  class ValidationResult {
    private readonly hasError: boolean;
    private readonly errorMessage: string;
  
    constructor(hasError?: boolean, errorMessage?: string){
      this.hasError = hasError ?? false;
      this.errorMessage = errorMessage ?? "";
    }
  
    public checkError() {
      return this.hasError;
    }
  
    public getErrorMessage() {
      return this.errorMessage;
    }
  }
  
  class PurchaseService {
    private readonly salesRuleValidator: SalesRuleValidator;
  
    public constructor(salesRuleValidator: SalesRuleValidator) {
      this.salesRuleValidator = salesRuleValidator;
    }
  
    public purchase(user: User, product: Product){
      const salesRuleValidationResult: ValidationResult = this.salesRuleValidator.validate(user, product);
      
      if(salesRuleValidationResult.checkError()){
        throw new Error(salesRuleValidationResult.getErrorMessage());
      }
  
      // 購入手続きに進む
    }
  }