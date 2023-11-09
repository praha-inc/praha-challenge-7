export class ForArithmeticOperations {
  private MAX_NUMBER_OF_ARGUMENTS: number = 30;
  private MAX_RESULT_VALUE: number = 1000;
  private NUMBER_OF_DIGITS_TO_ROUND_UP: number = 5;

  private values: number[];

  constructor(...values: number[]) {
    if (values.length == 0) {
      throw new Error('Number of arguments is 0')
    }
    if (values.length > this.MAX_NUMBER_OF_ARGUMENTS) {
      throw new Error('Number of arguments should be within 30')
    }
    values.forEach(value => {
      if (typeof value !== 'number') {
        throw new Error('All arguments must be numbers');
      }
    });
    this.values = values;
  }

  add() {
    let result = 0
    for (let i = 0; i < this.values.length; i++) {
      result += this.values[i]
      if (result > this.MAX_RESULT_VALUE) {
        return 'too big'
      }
    }
    return this.roundToSixthDecimalPlace(result)
  }

  subtract(): any {

    let result = this.values[0]
    for (let i = 1; i < this.values.length; i++) {
      result -= this.values[i]
    }
    if (result < 0) {
      return 'negative number'
    }
    return this.roundToSixthDecimalPlace(result)
  }

  multiply(): any {
    let result = 1
    for (let i = 0; i < this.values.length; i++) {
      result *= this.values[i]
      if (result > this.MAX_RESULT_VALUE) {
        return 'big big number'
      }
    }
    return this.roundToSixthDecimalPlace(result)
  }

  divide(): any {
    let result = this.values[0]
    for (let i = 1; i < this.values.length; i++) {
      result /= this.values[i]
    }
    return this.roundToSixthDecimalPlace(result)
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
  private roundToSixthDecimalPlace(value: number): number {
    const multiplier = Math.pow(10, this.NUMBER_OF_DIGITS_TO_ROUND_UP);
    return Math.round(value * multiplier) / multiplier;
  }
}