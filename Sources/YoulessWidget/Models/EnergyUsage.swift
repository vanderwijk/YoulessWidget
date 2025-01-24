public struct EnergyUsage: Codable {
    public let cnt: String
    public let pwr: Int
    public let lvl: Int
    public let dev: String
    public let det: String
    public let con: String
    public let sts: String
    public let cs0: String
    public let ps0: Int
    public let raw: Int

    public init(cnt: String, pwr: Int, lvl: Int, dev: String, det: String, con: String, sts: String, cs0: String, ps0: Int, raw: Int) {
        self.cnt = cnt
        self.pwr = pwr
        self.lvl = lvl
        self.dev = dev
        self.det = det
        self.con = con
        self.sts = sts
        self.cs0 = cs0
        self.ps0 = ps0
        self.raw = raw
    }
}