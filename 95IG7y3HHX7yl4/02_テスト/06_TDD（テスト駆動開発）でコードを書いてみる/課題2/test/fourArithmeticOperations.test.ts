import { ForArithmeticOperations } from '../src/fourArithmeticOperations' 

describe('四則演算', () => {
  let object = new ForArithmeticOperations()
  describe('足し算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、2が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(1, 1)).toBe(2)
      })

      test('引数が1と2の場合、3が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(1, 2)).toBe(3)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 0個の場合、エラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.add();
        }).toThrow('Number of arguments is 0');
      })

      test('引数が 1個の場合、1を 1個渡すと 1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(1)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(...Array(30).fill(1))).toBe(30)
      })

      
      test('引数が31個の場合、1を31個渡すとエラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.add(...Array(31).fill(1));
        }).toThrow('Number of arguments should be within 30');
      })
    })

    describe('引数が数字以外だとエラーが発生する', () => {
      test('引数にStringを渡すとエラーが発生する', () => {
        // コンパイル時にエラーに為るためコメントアウト
        // expect(object.add('String'));
      })
    })

    describe('計算結果が1000を超える場合は合計ではなく「too big」と文字列が返る', () => {
      test('引数が1001の場合、"too big"という文字列が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(1001)).toBe('too big');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が1/3と1/3の場合、0.66667が返ってくる', () => {
        // 準備・実行・確認
        expect(object.add(1/3, 1/3)).toBe(0.66667);
      })
    })
  })

  describe('引き算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、0が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(1, 1)).toBe(0)
      })

      test('引数が2と1の場合、1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(2, 1)).toBe(1)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 0個の場合、エラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.subtract();
        }).toThrow('Number of arguments is 0');
      })

      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(1)).toBe(1)
      })

      test('引数が30個の場合、30と1を29個渡すと1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(30, ...Array(29).fill(1))).toBe(1)
      })

      test('引数が31個の場合、1を31個渡すとエラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.subtract(...Array(31).fill(1));
        }).toThrow('Number of arguments should be within 30');
      })
    })

    describe('引数が数字以外だとエラーが発生する', () => {
      test('引数にStringを渡すとエラーが発生する', () => {
        // コンパイル時にエラーに為るためコメントアウト
        // expect(object.subtract('String'));
      })
    })

    describe('計算結果がマイナスの場合は「negative number」と文字列が返る', () => {
      test('引数が-1の場合、"negative number"という文字列が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(-1)).toBe('negative number');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が1と1/3の場合、0.66667が返ってくる', () => {
        // 準備・実行・確認
        expect(object.subtract(1, 1/3)).toBe(0.66667);
      })
    })
  })

  describe('掛け算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(1, 1)).toBe(1)
      })

      test('引数が1と2の場合、2が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(1, 2)).toBe(2)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 0個の場合、エラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.multiply();
        }).toThrow('Number of arguments is 0');
      })

      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(1)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(...Array(30).fill(1))).toBe(1)
      })

      test('引数が31個の場合、1を31個渡すとエラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.multiply(...Array(31).fill(1));
        }).toThrow('Number of arguments should be within 30');
      })
    })

    describe('引数が数字以外だとエラーが発生する', () => {
      test('引数にStringを渡すとエラーが発生する', () => {
        // コンパイル時にエラーに為るためコメントアウト
        // expect(object.multiply('String'));
      })
    })

    describe('計算結果が1000を越える場合は「big big number」と文字列が返る', () => {
      test('引数が1001の場合、"big big number"という文字列が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(1001)).toBe('big big number');
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が2と1/3の場合、0.66667が返ってくる', () => {
        // 準備・実行・確認
        expect(object.multiply(2, 1/3)).toBe(0.66667);
      })
    })
  })

  describe('割り算', () => {
    describe('渡された引数に対して計算を行い、結果を返す', () => {
      test('引数が1と1の場合、1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.divide(1, 1)).toBe(1)
      })

      test('引数が1と0.5の場合、2が返ってくる', () => {
        // 準備・実行・確認
        expect(object.divide(1, 1/2)).toBe(2)
      })
    })

    describe('1個〜30個までの引数を受け取る', () => {
      test('引数が 0個の場合、エラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.divide();
        }).toThrow('Number of arguments is 0');
      })

      test('引数が 1個の場合、1を 1個渡すと1が返ってくる', () => {
        // 準備・実行・確認
        expect(object.divide(1)).toBe(1)
      })

      test('引数が30個の場合、1を30個渡すと30が返ってくる', () => {
        // 準備・実行・確認
        expect(object.divide(...Array(30).fill(1))).toBe(1)
      })

      test('引数が31個の場合、1を31個渡すとエラーが発生する', () => {
        // 準備・実行・確認
        expect(() => {
          object.divide(...Array(31).fill(1));
        }).toThrow('Number of arguments should be within 30');
      })
    })

    describe('引数が数字以外だとエラーが発生する', () => {
      test('引数にStringを渡すとエラーが発生する', () => {
        // コンパイル時にエラーに為るためコメントアウト
        // expect(object.divide('String'));
      })
    })

    describe('計算結果が小数点以下が5桁より大きい場合、小数点代5を四捨五入する', () => {
      test('引数が2と3の場合、0.66667が返ってくる', () => {
        // 準備・実行・確認
        expect(object.divide(2, 3)).toBe(0.66667);
      })
    })
  })
})