export class Parameter {
  static MAX_NUMBER_OF_ARGUMENTS: number = 30;

  readonly values: number[];

  constructor(...values: number[]) {
    if (values.length == 0) {
      throw new Error('Number of arguments is 0')
    }
    if (values.length > Parameter.MAX_NUMBER_OF_ARGUMENTS) {
      throw new Error('Number of arguments should be within 30')
    }
    values.forEach(value => {
      if (typeof value !== 'number') {
        throw new Error('All arguments must be numbers');
      }
    });
    this.values = values;
  }
}


export class ForArithmeticOperations {
  static MAX_RESULT_VALUE: number = 1000;
  static NUMBER_OF_DIGITS_TO_ROUND_UP: number = 5;

  static add(param: Parameter) {
    let result = 0
    for (let i = 0; i < param.values.length; i++) {
      result += param.values[i]
      if (result > ForArithmeticOperations.MAX_RESULT_VALUE) {
        return 'too big'
      }
    }
    return ForArithmeticOperations.roundToSixthDecimalPlace(result)
  }

  static subtract(param: Parameter): any {
    let result = param.values[0]
    for (let i = 1; i < param.values.length; i++) {
      result -= param.values[i]
    }
    if (result < 0) {
      return 'negative number'
    }
    return ForArithmeticOperations.roundToSixthDecimalPlace(result)
  }

  static multiply(param: Parameter): any {
    let result = 1
    for (let i = 0; i < param.values.length; i++) {
      result *= param.values[i]
      if (result > ForArithmeticOperations.MAX_RESULT_VALUE) {
        return 'big big number'
      }
    }
    return ForArithmeticOperations.roundToSixthDecimalPlace(result)
  }

  static divide(param: Parameter): any {
    let result = param.values[0]
    for (let i = 1; i < param.values.length; i++) {
      if (param.values[i] === 0) {
        throw new Error("Division by zero is undefined and not allowed.");
      }
      result /= param.values[i]
    }
    return ForArithmeticOperations.roundToSixthDecimalPlace(result)
  }

  /**
   * 数値を小数点以下6桁目で四捨五入します。
   *
   * @param {number} value - 四捨五入を行いたい数値。
   * @returns {number} 小数点以下5桁目で四捨五入された数値。
   *
   * @example
   * roundToSixthDecimalPlace(123.456789123);  // 123.456789を返します
   */
  static roundToSixthDecimalPlace(value: number): number {
    const multiplier = Math.pow(10, this.NUMBER_OF_DIGITS_TO_ROUND_UP);
    return Math.round(value * multiplier) / multiplier;
  }
}