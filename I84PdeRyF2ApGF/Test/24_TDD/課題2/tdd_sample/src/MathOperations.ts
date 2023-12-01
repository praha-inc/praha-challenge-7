/**
 * 計算定数クラス
 * @description 計算処理で使用する結果の上限値やメッセージを定義する
 */
export class CalcConstants {
    public static readonly MaxArgs = 30;
    public static readonly MinResult = 0;
    public static readonly MaxResult = 1000;
    public static readonly TooMuchArgs = 'too much args!';
    public static readonly OnlyNumber = 'only number!';
    public static readonly OverMaxResult = 'too big';
    public static readonly UnderMinResult = 'negative number';
    public static readonly BigNumber = 'big big number';
    public static readonly DivideByZero = 'cannot divide by zero';
}

/**
 * 計算引数クラス
 */
export class CalculationArgs{
    private readonly numbers: number[];

    constructor(...numbers: number[]){
        this.validate(numbers);
        this.numbers = numbers;
    }

    getNumbers(): number[]{
        return this.numbers;
    }

    /**
     * 引数のバリデーション
     * @param numbers 
     * @description 引数が31個以上の場合と、引数に文字列が含まれる場合にエラーが発生する
     */
    private validate = (numbers: number[]): void => {
        if(numbers.length > CalcConstants.MaxArgs){
            throw new Error(CalcConstants.TooMuchArgs);
        }
        if(numbers.some(number => typeof number !== 'number')){
            throw new Error(CalcConstants.OnlyNumber);
        }
    }
}

/**
 * 計算処理クラス
 * @description 四則演算の処理を行う
 */
export class MathOperations{
    /**
     * 足し算
     * @param args 計算引数クラス
     * @returns 引数を足し合わせた結果
     * @description 引数の合計が1000を超える場合、文字列「too big」を返す
    */
   public static add = (args: CalculationArgs): number|string => {
       const numbers = args.getNumbers();
       const result = numbers.reduce((prev: number, current: number) => prev + current);
       
       return result > CalcConstants.MaxResult ? CalcConstants.OverMaxResult : result;
    }
    
    /**
     * 引き算
     * @param args 計算引数クラス
     * @returns　引数を左から順に引いた結果
     * @description 引数の差が0を下回る場合、文字列「negative number」を返す
    */
   public static subtract = (args: CalculationArgs): number|string => {
       const nubmers = args.getNumbers();
       const result = nubmers.reduce((prev: number, current: number) => prev - current);
       
       return result < CalcConstants.MinResult ? CalcConstants.UnderMinResult : result;
    }
    
    /**
     * 掛け算
     * @param args 計算引数クラス
     * @returns 引数を左から順に掛けた結果
     * @description 引数の積が1000を超える場合、文字列「big big number」を返す
    */
   public static multiply = (args: CalculationArgs): number|string => {
       const numbers = args.getNumbers();
       const result = numbers.reduce((prev: number, current: number) => prev * current);
       
       return result > CalcConstants.MaxResult ? CalcConstants.BigNumber : result;
    }
    
    /**
     * 割り算
     * @param args 計算引数クラス
     * @returns 引数を左から順に割った結果
     * @description 引数に０が含まれる場合、文字列「cannot divide by zero」を返す
    */
   public static divide = (args: CalculationArgs): number|string => {
       const numbers = args.getNumbers();
       if(numbers.includes(0)) {
           return CalcConstants.DivideByZero;
        }
        const result = numbers.reduce((prev: number, current: number) => prev / current);
        const roundedresult = Math.round(result * 100) / 100;
        return roundedresult;
    }

    // 四則演算引数クラスにValidateを移動したため、コメントアウト   
    //  public static validate = (args: any[]): void => {
    //      if(args.length > 30){
    //          throw new Error(CalcConstants.TooMuchArgs);
    //       }
    //       if(args.some(arg => typeof arg !== 'number')){
    //           throw new Error(CalcConstants.OnlyNumber);
    //       }
    //   }
}