import { ForArithmeticOperations, Parameter } from '../src/fourArithmeticOperations';

describe('四則演算', () => {
  describe('コンストラクタに渡す引数のバリデーション', () => {
    test('引数が 0個の場合、エラーが発生する', () => {
      expect(() => {
        // 準備・実行・確認
        new Parameter();
      }).toThrow('Number of arguments is 0');
    })

    test('引数が31個の場合、1を31個渡すとエラーが発生する', () => {
      expect(() => {
        // 準備・実行・確認
        new Parameter(...Array(31).fill(1));
      }).toThrow('Number of arguments should be within 30');
    })

    test('引数にStringを渡すとエラーが発生する', () => {
      expect(() => {
        // 準備・実行・確認
        new Parameter('String' as unknown as number);
      }).toThrow('All arguments must be numbers');
    })
  })

  describe('足し算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、2が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1);
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe(2)
      })

      test('引数が1と2の場合、3が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 2);
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe(3)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 1個の場合、1を 1個渡すと 1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1);
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備
        let parameter = new Parameter(...Array(30).fill(1));
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe(30)
      })
    })

    describe('計算結果が1000を超える場合は合計ではなく「too big」と文字列が返る', () => {
      test('引数が1001の場合、"too big"という文字列が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1001);
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe('too big');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が1/3と1/3の場合、0.66667が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1 / 3, 1 / 3);
        // 実行・確認
        expect(ForArithmeticOperations.add(parameter)).toBe(0.66667);
      })
    })
  })

  describe('引き算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、0が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1);
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe(0)
      })

      test('引数が2と1の場合、1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(2, 1);
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe(1)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1);
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe(1)
      })

      test('引数が30個の場合、30と1を29個渡すと1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(30, ...Array(29).fill(1));
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe(1)
      })
    })

    describe('計算結果がマイナスの場合は「negative number」と文字列が返る', () => {
      test('引数が-1の場合、"negative number"という文字列が返ってくる', () => {
        // 準備
        let parameter = new Parameter(-1);
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe('negative number');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が1と1/3の場合、0.66667が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1 / 3);
        // 実行・確認
        expect(ForArithmeticOperations.subtract(parameter)).toBe(0.66667);
      })
    })
  })

  describe('掛け算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1);
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe(1)
      })

      test('引数が1と2の場合、2が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 2);
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe(2)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1);
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備
        let parameter = new Parameter(...Array(30).fill(1));
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe(1)
      })
    })

    describe('計算結果が1000を越える場合は「big big number」と文字列が返る', () => {
      test('引数が1001の場合、"big big number"という文字列が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1001);
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe('big big number');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が2と1/3の場合、0.66667が返ってくる', () => {
        // 準備
        let parameter = new Parameter(2, 1 / 3);
        // 実行・確認
        expect(ForArithmeticOperations.multiply(parameter)).toBe(0.66667);
      })
    })
  })

  describe('割り算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1);
        // 実行・確認
        expect(ForArithmeticOperations.divide(parameter)).toBe(1)
      })

      test('引数が1と0.5の場合、2が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1, 1 / 2);
        // 実行・確認
        expect(ForArithmeticOperations.divide(parameter)).toBe(2)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備
        let parameter = new Parameter(1);
        // 実行・確認
        expect(ForArithmeticOperations.divide(parameter)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備
        let parameter = new Parameter(...Array(30).fill(1));
        // 実行・確認
        expect(ForArithmeticOperations.divide(parameter)).toBe(1)
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が2と3の場合、0.66667が返ってくる', () => {
        // 準備
        let parameter = new Parameter(2, 3);
        // 実行・確認
        expect(ForArithmeticOperations.divide(parameter)).toBe(0.66667);
      })
    })

    describe('0で除算された際にエラーを返す', () => {
      test('引数が1と0の場合、エラーが発生する', () => {
        // 準備
        let parameter = new Parameter(1, 0);
        expect(() => {
          // 実行・確認
          ForArithmeticOperations.divide(parameter);
        }).toThrow('Division by zero is undefined and not allowed.');
      })
    })
  })
})