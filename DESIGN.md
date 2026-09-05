# DESIGN.md — Shopping MVC Design System & Visual Strategy

**Design Archetype:** Technical Editorial Commerce  
**Version:** 2.0  
**Target Positioning:** Commercial Premium Tech & Electronics Retail  

---

## 1. Brand Personality & Emotional Tone
- **Personality:** Authoritative, architectural, precise, trustworthy, calm.
- **Tone:** Technical yet accessible — speaks the language of high-performance consumer technology, not generic discounts or marketing hype.
- **Core Principle:** The product is the hero. All layout, typography, and borders exist solely to frame and elevate the merchandise with zero decorative clutter.

---

## 2. Anti-AI Design Safeguards
The following common AI-generated patterns are strictly prohibited in this codebase:
1. **No "AI Hero"**: No centered giant gradient text, no arbitrary blurred ambient blobs, no angled floating 3D mockups.
2. **No "Pill Overload"**: No random rounded pill badges on every card, header, and button.
3. **No "Card-in-a-Card" Monotony**: Avoid boxing every sentence into a rounded card with soft blurry drop shadows. Use hairline rules, whitespace, and typographic contrast instead.
4. **No Mechanical 4-Feature Grids**: Remove the copy-paste icon-in-colored-circle feature cards.
5. **No Technology Stack Leakage**: Implementation technologies (JPA, Jakarta Servlet, SiteMesh, Hibernate, Spring, MVC, CRUD, SQL Server) are invisible infrastructure and MUST NEVER appear as visual copy or badges in customer-facing or administrative UI.

---

## 3. Typography System
- **Display & Headings:** `Plus Jakarta Sans`, sans-serif
  - Tight tracking (`-0.03em`), high contrast, geometric clarity.
  - Weights: `600` (Semi-bold), `700` (Bold), `800` (Extra-bold).
- **Body & Controls:** `Plus Jakarta Sans`, sans-serif
  - Weights: `400` (Regular), `500` (Medium).
  - Line height: `1.5` to `1.6` for comfortable reading.
- **Technical Metadata, SKUs, Stock & Currency:** `JetBrains Mono`, monospace
  - Weights: `500` (Medium), `600` (Semi-bold).
  - Letter spacing: `0.04em` to `0.08em` for crisp instrumentation feel.

---

## 4. Color Hierarchy & Budget
- **Canvas / Background:**
  - Light mode: `#f8fafc` (Soft off-white slate) & `#ffffff` (Pure card surface).
  - Dark surfaces / Admin sidebar: `#090d14` (Deep obsidian) & `#0f172a` (Graphite).
- **Hairlines & Dividers:**
  - `#e2e8f0` (Light borders, `1px solid`).
  - `rgba(255, 255, 255, 0.08)` (Dark mode borders).
- **Typography / Ink:**
  - Primary text: `#090d15` (Deepest charcoal/black, 98% contrast).
  - Secondary text: `#475569` (Cool slate).
  - Tertiary / Caption: `#94a3b8` (Subtle muted).
- **Accent Budget (Strict 1-Color Authority):**
  - Primary Action / Retail Focus: `#1d4ed8` (Cobalt Precision Blue) with hover `#1e40af`.
  - Signal Orange (Stock / Promo Tag): `#ea580c` (High-contrast signal orange).
  - Signal Green (In-stock / Active): `#16a34a`.
  - Signal Red (Out of stock / Danger): `#dc2626`.

---

## 5. Surface & Component Language
- **Corner Radius:**
  - Subtle architectural precision: `6px` (`rounded-1`), `8px` (`rounded-2`), max `12px` (`rounded-3`).
  - No balloon-like 24px/32px rounded corners on regular cards.
- **Elevation:**
  - Zero heavy blurry box-shadows.
  - Elevation is achieved via crisp `1px` border definition (`border: 1px solid #e2e8f0`) plus micro-shadow `0 1px 2px rgba(0,0,0,0.04)`.
- **Product Card Architecture:**
  - Clean frame with fixed aspect-ratio image stage (`1:1` or `4:3`).
  - Monospace category metadata tag.
  - Clear 2-line clamped product title.
  - Prominent price formatting (`#,##0 ₫`) with stock status dot.
  - Action buttons integrated flush with card geometry.

---

## 6. Motion & Interaction Standards
- **Intensity:** Low-to-Medium.
- **Timing:** Fast, tactile micro-transitions (`120ms` to `180ms cubic-bezier(0.16, 1, 0.3, 1)`).
- **Purpose:** Provide immediate feedback on hover, focus, and submission; never block user interaction or scroll performance.
- **Accessibility:** 100% compliant with `@media (prefers-reduced-motion: reduce)`.
