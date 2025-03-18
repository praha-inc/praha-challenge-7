namespace MyNamespace {
  class PersonName {
    constructor(
      public readonly firstName: string,
      public readonly lastName: string,
      public readonly middleName?: string
    ) {}
  }

  class Worker {
    private _startWorkingAt?: Date;
  
    constructor(public readonly name: PersonName) {}
  
    public get startWorkingAt(): Date | undefined {
      return this._startWorkingAt;
    }
  
    /**
     * 従業員の始業時刻を設定する
     * 
     * @remarks
     * - 未来の日時を設定することはできません。
     * - 既に始業時刻が設定されている場合、再設定はできません。
     * 
     * @param startWorkingAt - 始業時刻
     * @throws {Error} 未来の時刻を設定しようとした場合、エラーをスロー
     * @throws {Error} 既に始業時刻が設定されている場合、エラーをスロー
     */
    public assignStartWorkingAt(startWorkingAt: Date) {
      if (startWorkingAt >= new Date()) {
        throw new Error("未来の時刻を設定することは出来ません。");
      }
      if (this._startWorkingAt !== undefined) {
        throw new Error("始業時刻は設定済みです。上書きは出来ません。");
      }
      this._startWorkingAt = startWorkingAt;
    }
  }

  class Company {
    private readonly _workers: Worker[];
    constructor(workers: Worker[]) {
      // シャローコピー：元のworkersが変更されても、影響を受けないようにする為。
      this._workers = [...workers];
    }

    get workers() {
      return [...this._workers];
    }
  }

  function main() {
    // constructorやpublicな関数からのみ内部データを変更出来る
    const company = new Company([
      new Worker(new PersonName('友輔', '山﨑')),
      new Worker(new PersonName('寛', '阿部'))
    ]);
    company.workers[0].assignStartWorkingAt(new Date());
    company.workers[1].assignStartWorkingAt(new Date());

    // 外部から自由にデータに変更できない
    company.workers[0].name.firstName = 'AAA';
    company.workers[0].name.lastName = 'BBB';
    company.workers[0].name.middleName = 'CCC';
    company.workers[0].name = PersonName('DDD', '####');
    company.workers[0]._startWorkingAt = new Date('999-01-01');
    company.workers = [];
    // 再度始業時間を設定するとエラーが発生する
    company.workers[0].assignStartWorkingAt(new Date());
    // 外部からworkers追加しても、companyの持つデータに影響を与える事は出来ない
    company.workers.push(new Worker(new PersonName('サダヲ', '阿部')));
  }
}


