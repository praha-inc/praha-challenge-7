import { MathOperations, CalculationArgs} from "../src/MathOperations";

describe('add', () => {
    test('1と2を渡した時、3を返す', () => {
        const args: CalculationArgs = new CalculationArgs(1, 2);
        const actual: number|string = MathOperations.add(args);
        expect(actual).toEqual(3);
    });

    test('990と10と1を渡した時、「too big」を返す', () => {
        const args: CalculationArgs = new CalculationArgs(990, 10, 1);
        const actual: number|string = MathOperations.add(args);
        expect(actual).toEqual('too big');
    });
})

describe('subtract', () => {    
    test('2と1を渡した時、1を返す', () => {
        const args: CalculationArgs = new CalculationArgs(2, 1);
        const actual: number|string = MathOperations.subtract(args);
        expect(actual).toEqual(1);
    });

    test('4,3,2を渡した時、「negative number」と文字列を返す。', () => {
        const args: CalculationArgs = new CalculationArgs(4, 3, 2);
        const actual: number|string = MathOperations.subtract(args);
        expect(actual).toEqual('negative number');
    });
});

describe('multiply', () => {
    test('2と3を渡した時、6を返す', () => {
        const args: CalculationArgs = new CalculationArgs(2, 3);
        const actual: number|string = MathOperations.multiply(args);
        expect(actual).toEqual(6);
    });

    test('2,3,4,0を渡した時、0を返す', () => {
        const args: CalculationArgs = new CalculationArgs(2, 3, 4, 0);
        const actual: number|string = MathOperations.multiply(args);
        expect(actual).toEqual(0);
    });

    test('10,10,10,2を渡した時、「big big number」と文字列を返す。', () => {
        const args: CalculationArgs = new CalculationArgs(10, 10, 10, 2);
        const actual: number|string = MathOperations.multiply(args);
        expect(actual).toEqual('big big number');
    });
});


describe('divide', ()=>{
    test('10と2と渡した時、5を返す', () => {
        const args: CalculationArgs = new CalculationArgs(10, 2);
        const actual: number|string = MathOperations.divide(args);
        expect(actual).toEqual(5);
    });
    
    test('100,2,2,5,5を渡した時、1を返す', () => {
        const args: CalculationArgs = new CalculationArgs(100, 2, 2, 5, 5);
        const actual: number|string = MathOperations.divide(args);
        expect(actual).toEqual(1);
    });
    
    test('5と0を渡した時、「cannot divide by zero」と文字列を返す' , () => {
        const args: CalculationArgs = new CalculationArgs(5, 0);
        const actual: number|string = MathOperations.divide(args);
        expect(actual).toEqual('cannot divide by zero');
    });
    
    test('10と3を渡した時、3.33を返す', () => {
        const args: CalculationArgs = new CalculationArgs(10, 3);
        const actual: number|string = MathOperations.divide(args);
        expect(actual).toEqual(3.33);
    });
    
    test('9と8を渡した時、1.26を返す', () => {
        const args: CalculationArgs = new CalculationArgs(9, 8);
        const actual: number|string = MathOperations.divide(args);
        expect(actual).toEqual(1.13);
    });
});

// 値オブジェクトを採用したため、不要になったテスト
// describe('validate', () => {
//     test('引数が31個以上の場合、エラーが発生する', () =>{
//         let param: number[] = Array.from({length: 31}, (_, index) => index);
//         expect(() => MathOperations.validate(param)).toThrow(Error('too much args!'));
//     });
    
//     test('引数にaを渡すとの場合、エラーが発生する', () => {
//         let param: any[] = Array.from({length: 3}, (_, index) => index);
//         param.push('a');
//         expect(() => MathOperations.validate(param)).toThrow(Error('only number!'));
//     });
// });

describe('CalculationArgs', () => {
    test('引数に1,2,3を渡すと、getNumbersで1,2,3が返る', () => {
        const args: CalculationArgs = new CalculationArgs(1, 2, 3);
        expect(args.getNumbers()).toEqual([1, 2, 3]);
    });

    test('引数にaを渡すと、エラーが発生する', () => {
        expect(() => new CalculationArgs(1, 2, 3, 'a' as any)).toThrow(Error('only number!'));
    });

    test('引数に31個以上の値を渡すと、エラーが発生する', () => {
        let param: number[] = Array.from({length: 31}, (_, index) => index);
        expect(() => new CalculationArgs(...param)).toThrow(Error('too much args!'));
    });
});