# 課題 1

GPT さんの力をかなり借りました。こういう世に知られた概念みたいなのを勉強するにはめちゃいいですね。

## SOLID 原則

[参考](https://zenn.dev/nakurei/books/solid-principle-kanzen-rikai/viewer/about)

### S : Single responsibility principle（単一責任の原則）

- 責務を負う対象を一つにする（変更理由を一つにする？）、概念が異なるものをまとめてはならない
- モジュールは一つのことを行うべきという原則**ではない**（どゆこと？）
- 責務ってなんだろうか…
- 守られないと、何かを変更する度に、影響を受ける全モジュールの調査、テストが必要

### O : Open/closed principle（オープン・クローズドの原則）

- モジュールは、拡張に対しては開いていて、変更に対しては閉じていなければならない＝既存のコードを変更せず新しい機能を追加できるようにすべき

### L : Liskov substitution principle（リスコフの置換原則）

- サブタイプは、そのスーパータイプと置換可能でなければならない=スーパータイプを継承する際は、スーパータイプの代わりにサブタイプを利用しても、不都合のないようにしなければならない
- リスコフの置換原則を満たさないならば、継承を利用してはならない。
- 例えば動物というスーパータイプと人間というサブタイプがあったら、人間にできることは動物でもできるべき、ってこと…？→ 違う…スーパータイプのメソッドをオーバライドするときは、対象メソッドが想定している動作範囲を超えてはいけないってことか…？人間に新しいメソッドを生やすことは問題ない？
- なんでここだけ人名…[バーバラ・リスコフ](https://ja.wikipedia.org/wiki/%E3%83%90%E3%83%BC%E3%83%90%E3%83%A9%E3%83%BB%E3%83%AA%E3%82%B9%E3%82%B3%E3%83%95)

### I : Interface segregation principle（インターフェース分離の原則）

- クライアントからは、クライアントが必要とするメソッドのみが見えるべきであり、使わないメソッドが見えてはならない
- クライアントで一部のメソッドが未実装になる場合は、インターフェースの分離を検討すべき

_​ISP に従っていないインターフェースの例 ​_

```js
// 大きなインターフェースを定義
public interface IMultifunctionDevice {
    void printDocument(String doc);
    void scanDocument(String doc);
    void sendFax(String doc);
}

// クラスがこのインターフェースを実装
public class AllInOnePrinter implements IMultifunctionDevice {
    @Override
    public void printDocument(String doc) {
        // 印刷処理
    }

    @Override
    public void scanDocument(String doc) {
        // スキャン処理
    }

    @Override
    public void sendFax(String doc) {
        // ファックス処理
    }
}

// IMultifunctionDevice インターフェースを別のクラスで実装
public class SimplePrinter implements IMultifunctionDevice {
    @Override
    public void printDocument(String doc) {
        // 印刷処理
    }

    @Override
    public void scanDocument(String doc) {
        // 必要ないので空実装
    }

    @Override
    public void sendFax(String doc) {
        // 必要ないので空実装
    }
}
```

_​ISP に従ったインターフェースの修正例 ​_

```js
// 分割された小さなインターフェースを定義
public interface IPrinter {
    void printDocument(String doc);
}

public interface IScanner {
    void scanDocument(String doc);
}

public interface IFax {
    void sendFax(String doc);
}

// 必要なインターフェースのみを実装するクラス
public class AllInOnePrinter implements IPrinter, IScanner, IFax {
    @Override
    public void printDocument(String doc) {
        // 印刷処理
    }

    @Override
    public void scanDocument(String doc) {
        // スキャン処理
    }

    @Override
    public void sendFax(String doc) {
        // ファックス処理
    }
}

// シンプルなプリンタークラスは必要なインターフェースのみを実装
public class SimplePrinter implements IPrinter {
    @Override
    public void printDocument(String doc) {
        // 印刷処理
    }
}
```

### D : Dependency inversion principle（依存関係逆転の原則）

- 上位レベルのモジュールは下位レベルのモジュールに依存してはならない。両方とも抽象に依存すべきである。
- 抽象は詳細に依存してはならない。詳細が抽象に依存すべきである。

1. 依存関係が直接的な場合（改善前）

```js
// ログをファイルに書き込む実装
class FileLogWriter {
    public void write(String message) {
        // ファイルにログを書き込むコード
    }
}

// Loggerクラス依存
class Logger {
    private FileLogWriter logWriter;

    public Logger() {
        this.logWriter = new FileLogWriter();
    }

    public void log(String message) {
        logWriter.write(message);
    }
}
```

1. 依存性の逆転を適用した場合（改善後）

```js
// まず、共通のインターフェースを定義
interface LogWriter {
    void write(String message);
}

// ファイルにログを書く実装
class FileLogWriter implements LogWriter {
    public void write(String message) {
        // ファイルにログを書き込むコード
    }
}

// コンソールにログを書く実装
class ConsoleLogWriter implements LogWriter {
    public void write(String message) {
        System.out.println(message);
    }
}

// Loggerクラスは、LogWriterインターフェースに依存
class Logger {
    private LogWriter logWriter;

    public Logger(LogWriter logWriter) {
        this.logWriter = logWriter;
    }

    public void log(String message) {
        logWriter.write(message);
    }
}

// 使用例
public class Main {
    public static void main(String[] args) {
        // ファイルにログを書きたい場合
        LogWriter fileLogWriter = new FileLogWriter();
        Logger fileLogger = new Logger(fileLogWriter);
        fileLogger.log("ファイルにログを書きます");

        // コンソールにログを書きたい場合
        LogWriter consoleLogWriter = new ConsoleLogWriter();
        Logger consoleLogger = new Logger(consoleLogWriter);
        consoleLogger.log("コンソールにログを書きます");
    }
}
```

### SOLID 原則を守ると

- 変更しやすくなる
- 読みやすくなる

クラスとか拡張とかあんまり使わないから正直あんまりピンとこないとこも多い…オブジェクト指向の影響が強い感じがしたが、関数っぽく書く流れだからピンとこないのかも。→ そもそもオブジェクト指向から生まれた原則なのか。

## 単一責任の原則と、単純にファイルを細かなファイルに分解することには、どのような違いがあるでしょうか？

分割の境界線をどこに置くかという話が重要なので、どんな境界でもいいからとにかく分ければいいというわけではない。

## Open-Closed-Principle の実例を一つ考えて、作成してみてください。TS Playground で書けるような簡単なサンプルで構いません！

```js
// Step 1: Shapeインターフェースを定義
interface Shape {
  getArea(): number;
}

// Step 2: Circleクラスを定義
class Circle implements Shape {
  constructor(private radius: number) {}

  getArea(): number {
    return Math.PI * this.radius * this.radius;
  }
}

// Step 4: 面積を表示する関数
function printArea(shapes: Shape[]): void {
  shapes.forEach(shape => {
    console.log(`Area: ${shape.getArea()}`);
  });
}

// テスト: Circleインスタンスを作成して面積を計算
const shapes: Shape[] = [
  new Circle(5),
];

printArea(shapes);

// Step 5: 新しい形状（例えばTriangle）を追加しても、既存のコードには手を加えずに拡張可能
class Triangle implements Shape {
  constructor(private base: number, private height: number) {}

  getArea(): number {
    return 0.5 * this.base * this.height;
  }
}

// 新しいTriangleを追加
shapes.push(new Triangle(10, 15));

printArea(shapes);
```

## リスコフの置換原則に違反した場合、どのような不都合が生じるでしょうか？

1. コードの再利用性と保守性の低下
   • ​ 基底クラスのインスタンスの代わりにサブクラスのインスタンスを使用すると、予期しない動作やバグが発生
2. ポリモーフィズム（多態性）の破壊
   • ​ サブクラスが基底クラスの契約に一致しないと、ポリモーフィズムが正しく機能しない。これは、異なるクラスのオブジェクトを同じインターフェースを通じて操作するというオブジェクト指向の基本的な特性
3. テストの難易度の増加
   • ​ サブクラスが基底クラスのインターフェースを正しく実装していない場合、テストが複雑になり、異なるクラス間の一貫性を検証する必要がある
4. 可読性と理解性の低下
   • ​ 基底クラスとサブクラスの間で一貫性がなくなると、コードを理解するのが難しくなる。開発者はクラス階層のどの部分で何が起こっているのかを詳細にチェックしなければならなくなる

## インターフェースを用いる事で、設計上どのようなメリットがあるでしょうか？

1.  ​ クラスの特化と応答性の向上
    • インターフェースが分割されることで、クラスは自分が必要とする機能のみを実装できます。
2.  ​ 疎結合の促進と可読性の向上
    • 分割されたインターフェースを利用すれば、クラス間の依存関係が減少し、コードがより疎結合となります。
3.  ​ メンテナンス性の向上
    • 小さなインターフェースに分かれていることで、変更がしやすくなり、他の機能への影響が最小限に抑えられます。
4.  ​ テスト容易性の向上
    • 小さなインターフェースを用いることで、特定の機能をモックすることが容易になり、ユニットテストの精度が向上します。
5.  ​ 開発の分業化と効率化
    • 分割されたインターフェースにより、複数のチームが異なる機能の開発に集中でき、全体の開発速度が向上します。

## どんな時に依存性の逆転を用いる必要が生じるのでしょうか？

1. ​ 複数の実装をサポートする必要がある場合 ​
   シナリオ:​ アプリケーションが異なる環境や要件に応じて、複数のデータベースやストレージシステム（例えば、MySQL、PostgreSQL、MongoDB など）をサポートする必要がある場合。
1. ​ テストの容易化 ​
   シナリオ:​ ユニットテストを行う際に、外部サービス（例えば、Web API やデータベース）への依存を避けたい場合。
   適用例:​ 依存性の逆転を用いて、テスト時には実際のサービスの代わりにモック（模擬オブジェクト）やスタブを利用することで、より簡単にテストを実行できます。
1. ​ 再利用性の向上 ​
   シナリオ:​ 再利用可能なライブラリやフレームワークを開発している場合。
1. ​ 既存のシステムを新しい技術に移行する場合 ​
   シナリオ:​ 既存のコードベースを、新しいライブラリや外部サービスに移行したいが、一度にすべての変更を行うのが難しい場合。
   適用例:​ 段階的に新しい技術を導入するために、既存のインターフェースを利用し、順次新しい実装を追加することで、移行プロセスを円滑に進めることができます。
1. ​ サードパーティライブラリの利用 ​
   シナリオ:​ アプリケーションがサードパーティのライブラリやサービスに強く依存している場合、将来的にそのサービスが変更されたり終了したりするリスクがあります。
   適用例:​ 抽象化レイヤーを導入し、サードパーティのサービスを管理することで、将来的に異なるサービスに切り替えるコストを低減できます。
1. ​ 異なるプラットフォームをサポートする場合 ​
   シナリオ:​ アプリケーションが異なるプラットフォーム（例えば、デスクトップ、モバイル、ウェブ）で動作する必要がある場合。
   適用例:​ プラットフォーム固有の実装を抽象化するためのインターフェースを導入し、プラットフォームごとに異なる具体的な実装を提供することで、コードの共有部分は変更せずに、各プラットフォームに対応できます。

## デメトルの法則とは何でしょうか？業務経験 1 年目の IT エンジニアに伝わるように説明してください。この法則を守ることで、どのようなメリットがあるのでしょうか？

ソフトウェア開発における設計原則の一つで、「オブジェクトは一度に一つの仲間にしかメッセージを送らない」ことを推奨しています。別の言い方をすると、「必要以上に多くのオブジェクトについて知ることを避ける」ということです。

例え
例えば、あなたがレストランのシェフだとしましょう。料理を作るときに、直接農家に連絡して野菜を注文し、農場に取りに行くのではなく、食材業者に注文して届けてもらう方が効率的ですよね。シェフであるあなたは、料理を作ることに集中でき、農家や物流についての詳細は全く知らなくても良いわけです。

具体例

1 年目の IT エンジニアとして覚えておくべきは、「メソッドを呼び出すときに、チェーンの長さを最小限に保つ」ということです。つまり、以下のようなコードを書かないようにします：

```py
// 良くない例
class Account:
    def __init__(self, balance=0):
        self.balance = balance

    def get_balance(self):
        return self.balance

    def deposit(self, amount):
        self.balance += amount

    def withdraw(self, amount):
        self.balance -= amount

class User:
    def __init__(self, account):
        self.account = account

    def get_account(self):
        return self.account

# デメトルの法則に反するコード例
user = User(Account(100))
user.get_account().deposit(50)  # これは良くない
print(user.get_account().get_balance())  # これは良くない

// 良い例
class Account:
    def __init__(self, balance=0):
        self.balance = balance

    def deposit(self, amount):
        self.balance += amount

    def withdraw(self, amount):
        self.balance -= amount

class User:
    def __init__(self, account):
        self._account = account

    # デメトルの法則を遵守するメソッド追加
    def deposit_to_account(self, amount):
        self._account.deposit(amount)

    def get_account_balance(self):
        return self._account.get_balance()

# デメトルの法則に従うコード例
user = User(Account(100))
user.deposit_to_account(50)
print(user.get_account_balance())
```

- メソッドは、以下のオブジェクトのメソッドのみを呼び出すことができる：
  - 自分自身（this）
  - 自分のフィールド（メンバー変数）
  - メソッドの引数として渡されたオブジェクト（パラメータ）
  - メソッド内で生成されたローカル変数

デメトルの法則を守るメリット

1.  ​ メンテナンスが楽になる ​: コードの変更が必要になった場合、影響範囲を抑えやすくなります。
2.  ​ テストがしやすくなる ​: 各オブジェクトは自分の仕事に集中しているため、ユニットテストが容易になります。
3.  ​ 透明性が高まる ​: システムの各部分が他の部分に依存している度合いが少なくなることで、システム全体の理解がしやすくなります。
4.  ​ バグが減る可能性が高い ​: 他の部分に依存しないコードは、予期せぬ変更や不具合の影響を受けにくくなります。
    この法則を守ることで、より堅牢でメンテナンスしやすいソフトウェアを設計することができます。シンプルなコードを心がけ、オブジェクト同士の依存関係を減らすことを意識すると良いでしょう。

[参考](https://zenn.dev/miya_tech/articles/b59916140347e2)

## デメトルの法則を新人エンジニアに伝えたところ「わかりました！こうすれば良いのですね！」と、このようなコードを提出しました。これだけでは特にコードの保守性に対して効果が無いことを説明してあげてください

単に getter/setter を追加しただけで、結局他のクラスが内部状態に直接アクセスしている。オブジェクト間の結合度が高く、変更が他のオブジェクトに波及してしまう。

```js
class Purchase {
  private _user: User;
  private _product: Product;

  constructor(user: User, product: Product) {
    this._user = user;
    this._product = product;
  }

  // デメトルの法則に基づく操作メソッド
  public completePurchase() {
    // 購入完了のロジックを実装
    // たとえば、メールを送信、在庫を減少など
  }

  public getUserDetails() {
    // 必要なユーザー情報を返す
    return {
      name: this._user.getName(),
      email: this._user.getEmail(),
    };
  }
}
```

## デメテルの法則を守ることにはどのような意味/効果があるのでしょうか？

1. ​ カプセル化の向上：オブジェクト間の依存関係が減り、オブジェクトの内部実装が変更されたときでも他の部分に影響が少なくなる。理解もしやすい
2. ​ テスタブルになる：メソッドが他の多くのメソッドに依存しなくなるため、単体テストが容易に

# 課題 2

PurchaseService クラスが、購入履歴のチェックと購入手続きを両方担っているので分離して、新しい Interface を用意

- ​ 単一責任原則
- ​ オープン/クローズド原則
- インターフェース分離の原則

```js
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

interface PurchaseLimitPolicy {
  check(userId: string, productId: string): void
}

class AnnualPurchaseLimitPolicy implements PurchaseLimitPolicy {
  public constructor(private paymentRecordRepo: PaymentRecordRepo) {}

  public check(userId: string, productId: string): void {
    const allPurchases = this.paymentRecordRepo.getPurchasesBy(userId)
    const pastPurchase = allPurchases.find((p) => p.productId === productId && p.transaction.succeeded)
    if (pastPurchase) {
      throw new Error('この商品はおひとりさま一品限定です！')
    }
  }
}

class PurchaseService {
  public constructor(
    private paymentRecordRepo: PaymentRecordRepo,
    private purchaseLimitPolicy: PurchaseLimitPolicy
  ) {}

  public purchase(userId: string, productId: string) {
    this.purchaseLimitPolicy.check(userId, productId)
    // 購入手続きに進む
  }
}
```

## アプリ側で絞り込む場合

適切な条件

- データ量が比較的少なく、アプリケーションサーバーのリソースが十分にある場合。
- 複雑なビジネスロジックが頻繁に変更される場合。
- テストやメンテナンスの観点から、ビジネスロジックを集中管理したい場合。

## SQL 側で絞り込む場合

適切な条件

- データ量が非常に多く、アプリケーションでの絞り込み処理がパフォーマンス上のボトルネックになる場合。
- ビジネスロジックが比較的シンプルで、SQL での実装が直感的かつ管理しやすい場合。
- データベースの性能をフルに活用し、アプリケーションサーバーの負荷を軽減したい場合。

# 課題 3

```js
class Person {
  private _name: string
  private _startWorkingAt: Date

  constructor(name: string, startWorkingAt: Date) {
    this._name = name
    this._startWorkingAt = new Date(startWorkingAt.getTime()) // prevent reference mutation
  }

  public get name(): string {
    return this._name
  }

  public get startWorkingAt(): Date {
    return new Date(this._startWorkingAt.getTime()) // return a new Date object to prevent external mutation
  }

  public setStartWorkingAt(newDate: Date): void {
    if (newDate <= new Date()) {
      this._startWorkingAt = new Date(newDate.getTime())
    } else {
      throw new Error("start working date cannot be in the future")
    }
  }

  public changeName(newName: string): void {
    if (newName.trim() === "") {
      throw new Error("name cannot be empty")
    }
    this._name = newName
  }
}

class Company {
  private people: Person[]

  constructor(people: Person[]) {
    this.people = people
  }

  public getPeople(): Person[] {
    // Return a copy of the people array to prevent external mutation
    return this.people.map(person => new Person(person.name, person.startWorkingAt))
  }
}

const company = new Company([new Person('a', new Date('2021-01-01')), new Person('b', new Date('2021-01-01'))])
const firstPerson = company.getPeople()[0]
// 何らかのロジックに使用するため、Person Aの勤務開始日を取得
const date = firstPerson.startWorkingAt
// これで誤って更新できなくなる
date.setFullYear(1000) // この変更はPersonのオブジェクトに影響を与えない
```

## 「getter と setter を定義すれば良いんですね！」

getter と setter を使うだけでは、外部からの無制限な変更を防ぐ効果が低いため、セットする際に適切なバリデーションを行ったり、場合によってはイミュータブルなオブジェクトを返すことを考えるべき。

- ​ 外部からの Data Mutability の防止 ​：getter では直接の参照を返さず、新しいオブジェクトを返すことで、オリジナルオブジェクトが変更されないようにする。
- ​ バリデーションの重要性 ​：setter を使う際には、適切なバリデーションを実施することで、無効なデータがセットされることを防ぐ。

# 任意課題

## 凝集度

### Lv1. 偶発的凝集：ランダム

偶発的凝集 ​ とは、特定の理由や共通性がなく、ただなんとなく一緒にまとめられた機能や要素のことを指します。このタイプの凝集は、もっとも品質の低い凝集度であり、メンテナンスが非常に難しくなります。
例：ランダムに選ばれた関数がひとつのモジュール内に存在する。

### Lv2. 論理的凝集：同じカテゴリの機能がまとめられているが、内部では関係しない

論理的凝集 ​ は、同じカテゴリや種類に属する処理がひとつのモジュールにまとめられることを指します。処理が互いに依存しない場合でも、一緒にされることがポイントです。
例：入出力操作（ファイルの読み書きなど）をひとつのモジュールにまとめる。

```js
class IOOperations {
  readFile(filename) {
    // ファイルの読み込み
    console.log(`Reading file: ${filename}`);
  }

  writeFile(filename, data) {
    // ファイルの書き込み
    console.log(`Writing to file: ${filename}`);
  }

  printToConsole(message) {
    // コンソールへの出力
    console.log(message);
  }

  readFromDatabase(query) {
    // 仮のデータベース読み取り処理
    console.log(`Querying database: ${query}`);
    return "Sample data";
  }
}
```

### Lv3. 時間的凝集：特定のタイミングでまとめて実行

時間的凝集 ​ は、特定の時点やタイミングで一度に実行される必要がある処理がひとつのモジュールにまとめられることを指します。初期化処理やクリーンアップ処理が一般的な例です。
例：プログラムの開始時に一度だけ実行される初期化処理をまとめる。

### Lv4. 手続き的凝集（手順的凝集）：特定の順序で行う必要がある処理

手続き的凝集 ​ は、一定の手順や順序で実行される処理がひとつのモジュールにまとめられることを指します。これらの処理は互いに依存関係があることもポイントです。
例：データベースにアクセスしてデータを取得し、後でそのデータを処理する一連の操作。

```js
class DatabaseOperations {
  openConnection() {
    // 接続を開く
    console.log("Connection opened");
  }

  startTransaction() {
    // トランザクションを開始する
    console.log("Transaction started");
  }

  insertData(data) {
    // データを挿入する
    console.log(`Data inserted: ${data}`);
  }

  closeConnection() {
    // 接続を閉じる
    console.log("Connection closed");
  }
}
```

### Lv5. 通信的凝集：同じデータや関連するデータを扱う処理

通信的凝集 ​ は、同じデータを使用したり、関連するデータを処理する一連の操作がひとつのモジュールにまとめられることを指します。これらの操作はデータの変更や更新を伴います。
例：顧客情報を取得し、それを基にした請求処理や通知処理を行うモジュール。

```js
class CustomerDataManagement {
  getCustomerData(customerId) {
    // 顧客データの取得
    console.log(`Retrieving customer data for ID: ${customerId}`);
    return { id: customerId, name: "John Doe" };
  }

  updateCustomerData(customerId, newData) {
    // 顧客データの更新
    console.log(`Updating customer data for ID: ${customerId}`);
  }

  deleteCustomerData(customerId) {
    // 顧客データの削除
    console.log(`Deleting customer data for ID: ${customerId}`);
  }

  generateBillingInvoice(customerId) {
    // 請求書の生成
    console.log(`Generating billing invoice for customer ID: ${customerId}`);
  }
}
```

### Lv6. 逐次的凝集：出力が次の処理の入力となる一連の処理

逐次的凝集 ​ とは、ある処理の出力が次の処理の入力として引き継がれる一連の操作がひとつのモジュールにまとめられることを指します。逐次的な依存関係がポイントです。
例：テキストを読み込んで解析し、結果を出力する一連の操作。

### Lv7. 機能的凝集：特定の機能に関連する処理がまとめられた理想的な状態

機能的凝集 ​ は、特定のひとつの機能や目的を達成するための処理がひとつのモジュールにまとめられることを指します。これはもっとも理想的で、高品質な凝集度とされています。
例：ユーザー認証を行うためのすべての処理を含むモジュール。
以上のように、凝集度はモジュールの品質に大きな影響を与える重要な概念です。それぞれの凝集タイプを理解し、適切に設計することで、ソフトウェアの保守性と品質を向上させることができます。

レベルが高いほどよいとされる。

## 結合度

### Lv1. ​ 内部（内容）結合 (Internal Coupling)​：

    •   モジュールやコンポーネントが内部データやメカニズムに依存する結合のことです。外部とのインターフェースに影響せず、内部の詳細な実装に結びついています。モジュール内の変更が他のモジュールに影響を与えにくいのが特長です。

```js
// ModuleA.js
function calculate(a, b) {
  return a * b + 10; // 内部での計算ロジック
}

function moduleAFunction(x, y) {
  return calculate(x, y);
}

export { moduleAFunction };
```

### Lv2. ​ 共通結合 (Common Coupling)​：

    •   複数のモジュールが共通のグローバルデータを共有する際に生じる結合です。グローバル変数を使用する場合などが例に当たります。この結合は柔軟性を提供しますが、変更が影響しやすいため管理に注意が必要です。

```js
// global.js
let globalCounter = 0;
export { globalCounter };

// ModuleA.js
import { globalCounter } from "./global.js";

function incrementCounter() {
  globalCounter++;
}

export { incrementCounter };

// ModuleB.js
import { globalCounter } from "./global.js";

function resetCounter() {
  globalCounter = 0;
}

export { resetCounter };
```

### Lv3. ​ 外部（ハイブリッド）結合 (External Coupling)​：

    •   モジュール間が外部データやインターフェースを介して結びついていることを指します。たとえば、モジュールが共通のデータフォーマットや外部のAPIサービスを利用する場合です。外部要素が変わると、モジュール全体に影響します。

```js
// ModuleA.js
fetch("https://api.example.com/data")
  .then((response) => response.json())
  .then((data) => {
    console.log("Module A:", data);
  });

// ModuleB.js
fetch("https://api.example.com/data")
  .then((response) => response.json())
  .then((data) => {
    console.log("Module B:", data);
  });
```

### Lv4. ​ 制御結合 (Control Coupling)​：

    •   あるモジュールが別のモジュールに制御情報（フラグやパラメータなど）を渡すことで発生する結合です。他のモジュールからの制御フローに関する指示を受けるときに見られます。この結合はモジュールの独立性を低下させる可能性があります。

    ​具体例​：
    ModuleA が ModuleB にフラグを渡して動作を制御します。

```js
// ModuleA.js
import { setLoggingEnabled } from "./ModuleB.js";

function configureLogging(isEnabled) {
  setLoggingEnabled(isEnabled);
}

export { configureLogging };

// ModuleB.js
let loggingEnabled = false;

function setLoggingEnabled(isEnabled) {
  loggingEnabled = isEnabled;
  console.log(`Logging is now ${isEnabled ? "enabled" : "disabled"}.`);
}

export { setLoggingEnabled };
```

### Lv5. ​ スタンプ結合 (Stamp Coupling)​：

    •   モジュール間で共通した構造データ（レコードやクラスインスタンス）を受け渡しする結合です。詳細なデータの中の一部しか使用しないことが多いです。データの増減に対する耐性は高い反面、結合度が高いとデータ構造の変更影響が大きいです。

    ModuleA がオブジェクト employee を ModuleB に渡し、`ModuleB` はその一部だけを使用します。

```js
// ModuleA.js
import { handleEmployee } from "./ModuleB.js";

const employee = {
  id: 1,
  name: "John Doe",
  department: "Engineering",
  salary: 50000,
};

function processEmployee() {
  handleEmployee(employee);
}

export { processEmployee };

// ModuleB.js
function handleEmployee(employee) {
  console.log("Processing employee:", employee.name);
}

export { handleEmployee };
```

### Lv6. ​ データ結合 (Data Coupling)​：

    •   モジュール間で単一のデータ項目（例えば数値や文字列）を受け渡しする結合です。必要なデータのみ受け渡しされるため、結合度が低くモジュールの独立性が保たれやすいです。

ModuleA が単一のデータ employeeId を ModuleB に渡して処理を依頼します。

```js
// ModuleA.js
import { process } from "./ModuleB.js";

function processId(employeeId) {
  process(employeeId);
}

export { processId };

// ModuleB.js
function process(id) {
  console.log("Processing employee ID:", id);
}

export { process };
```

### Lv7. ​ メッセージ結合 (Message Coupling)​：

    •   モジュールがメッセージを介して情報を交換する結びつきです。特にオブジェクト指向プログラミングでは、オブジェクト間のメッセージパッシング（メソッド呼び出し）などが該当します。実装の詳細を隠し、メッセージインターフェースを使うことで結合度を低く保ちます。

    オブジェクト間でメッセージングを行います。インターフェースを使って相互作用します。

```js
// MessageReceiver.js
class MessageReceiver {
  receiveMessage(message) {
    console.log("Message received:", message);
  }
}

export { MessageReceiver };

// ClassA.js
import { MessageReceiver } from "./MessageReceiver.js";

class ClassA {
  constructor(receiver) {
    this.receiver = receiver;
  }

  sendMessage() {
    this.receiver.receiveMessage("Hello from A!");
  }
}

export { ClassA };

// Main.js
import { ClassA } from "./ClassA.js";
import { MessageReceiver } from "./MessageReceiver.js";

const messageReceiver = new MessageReceiver();
const classA = new ClassA(messageReceiver);

classA.sendMessage();
```

レベルが高いほどよい。

## 参考

- https://www.affordd.jp/koha_hp/KeyWords/KW.Coupling.html
