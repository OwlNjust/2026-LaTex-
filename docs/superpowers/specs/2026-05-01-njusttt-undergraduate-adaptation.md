# NJUST Undergraduate Thesis Template Adaptation (2026)

## Scope

Adapt the refactored NJUST PhD thesis template to the 2026 undergraduate (本科) format per the official university writing guide.

---

## Changes Map

### njusttt.def — Labels

| PhD (remove) | Undergraduate (add/modify) |
|---|---|
| `\NJUST@label@thesis` (博士学位论文) | `\NJUST@label@report` (毕业设计（论文）报告) |
| `\NJUST@label@classification` | Removed |
| `\NJUST@label@confidential` | Removed |
| `\NJUST@label@UDC` | Removed |
| `\NJUST@label@titleLab` | `\NJUST@label@titleNote` (学生姓名) |
| `\NJUST@label@authorLab` | `\NJUST@label@authorNote` (学号) |
| `\NJUST@label@advisor` | Keep |
| `\NJUST@label@coadvisor` | Removed |
| `\NJUST@label@degree` | `\NJUST@label@college` (学生学院) |
| `\NJUST@label@major` | `\NJUST@label@major` (专业) Keep |
| `\NJUST@label@interest` | `\NJUST@label@researchdir` (研究方向) |
| `\NJUST@label@submitdate` | `\NJUST@label@submitdate` (提交时间) Keep |
| `\NJUST@label@incoverauthor` | Keep (封二) |
| `\NJUST@label@incoveradvisor` | Keep (封二) |
| `\NJUST@label@incovercoadvisor` | Removed |
| `\NJUST@label@statement` | Updated content |
| `\NJUST@label@accredit` | Updated content |
| `\NJUST@label@thanks` | Keep |
| `\NJUST@value@pageDegree` | "毕业设计（论文）报告" |

### njusttt.def — Commands

| PhD (remove) | Undergraduate (add/modify) |
|---|---|
| `\classification`, `\confidential`, `\UDC` | Removed |
| `\titleUpp`, `\titleLow` | Keep (封面标题分两行) |
| `\coadvisor`, `\coadvisortitle` | Removed |
| `\degree` | Replaced by `\college` |
| `\interest` | `\researchdir` |
| `\titleBackbone`, `\schoolBackbone` | Removed |
| `\englishcoadvisor`, `\englishcoadvisortitle` | Removed |
| — | `\studentid` (新) |

### njusttt.cls — Page Layout

```
paper      = A4
top        = 30mm
bottom     = 24mm
left       = 25mm
right      = 25mm
headheight = 14pt
footskip   = 20mm
```

### njusttt.cls — Cover Pages

1. **`\makefrontcover`** — 毕业设计（论文）报告封面
2. **`\makeincover`** — 封二 (new)
3. **`\makeenglishincover`** — 英文封二 (new)
4. **`\makestatement`** — 声明 (updated content)
5. **`\makecover`** — calls 1-4

### njusttt.cls — Font Sizes

| Element | Size |
|---|---|
| Cover report title | 32pt bold |
| Cover paper title | 24pt bold |
| Level 1 heading | 小三 15pt bold |
| Level 2 heading | 四号 14pt bold |
| Level 3 heading | 小四 12pt bold |
| Body text | 小四 12pt |
| Abstract title | 三号 16pt bold |
| Figure/table caption | 五号 10.5pt |
| Table content | 五号 10.5pt |
| Header/footer | 小五 9pt |
| Line spacing | 固定 20pt |

### njusttt.cls — Headers

- Odd: "毕业设计（论文）报告 {title}"
- Even: "{chapter name}"

### Verification

Clean build: xelatex + biber + xelatex + xelatex, 0 errors.
