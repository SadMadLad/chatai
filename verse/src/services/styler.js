class Styler {
  constructor() {
    this.backgroundColorClasses = {
      slate: {
        light: "bg-slate-100",
        base: "bg-slate-500",
        dark: "bg-slate-700",
      },
      gray: { light: "bg-gray-100", base: "bg-gray-500", dark: "bg-gray-700" },
      zinc: { light: "bg-zinc-100", base: "bg-zinc-500", dark: "bg-zinc-700" },
      neutral: {
        light: "bg-neutral-100",
        base: "bg-neutral-500",
        dark: "bg-neutral-700",
      },
      stone: {
        light: "bg-stone-100",
        base: "bg-stone-500",
        dark: "bg-stone-700",
      },
      red: { light: "bg-red-100", base: "bg-red-500", dark: "bg-red-700" },
      orange: {
        light: "bg-orange-100",
        base: "bg-orange-500",
        dark: "bg-orange-700",
      },
      amber: {
        light: "bg-amber-100",
        base: "bg-amber-500",
        dark: "bg-amber-700",
      },
      yellow: {
        light: "bg-yellow-100",
        base: "bg-yellow-500",
        dark: "bg-yellow-700",
      },
      lime: { light: "bg-lime-100", base: "bg-lime-500", dark: "bg-lime-700" },
      green: {
        light: "bg-green-100",
        base: "bg-green-500",
        dark: "bg-green-700",
      },
      emerald: {
        light: "bg-emerald-100",
        base: "bg-emerald-500",
        dark: "bg-emerald-700",
      },
      teal: { light: "bg-teal-100", base: "bg-teal-500", dark: "bg-teal-700" },
      cyan: { light: "bg-cyan-100", base: "bg-cyan-500", dark: "bg-cyan-700" },
      sky: { light: "bg-sky-100", base: "bg-sky-500", dark: "bg-sky-700" },
      blue: { light: "bg-blue-100", base: "bg-blue-500", dark: "bg-blue-700" },
      indigo: {
        light: "bg-indigo-100",
        base: "bg-indigo-500",
        dark: "bg-indigo-700",
      },
      violet: {
        light: "bg-violet-100",
        base: "bg-violet-500",
        dark: "bg-violet-700",
      },
      purple: {
        light: "bg-purple-100",
        base: "bg-purple-500",
        dark: "bg-purple-700",
      },
      fuchsia: {
        light: "bg-fuchsia-100",
        base: "bg-fuchsia-500",
        dark: "bg-fuchsia-700",
      },
      pink: { light: "bg-pink-100", base: "bg-pink-500", dark: "bg-pink-700" },
      rose: { light: "bg-rose-100", base: "bg-rose-500", dark: "bg-rose-700" },
    };
    this.borderColorClasses = {
      slate: {
        light: "border-slate-100",
        base: "border-slate-500",
        dark: "border-slate-700",
      },
      gray: {
        light: "border-gray-100",
        base: "border-gray-500",
        dark: "border-gray-700",
      },
      zinc: {
        light: "border-zinc-100",
        base: "border-zinc-500",
        dark: "border-zinc-700",
      },
      neutral: {
        light: "border-neutral-100",
        base: "border-neutral-500",
        dark: "border-neutral-700",
      },
      stone: {
        light: "border-stone-100",
        base: "border-stone-500",
        dark: "border-stone-700",
      },
      red: {
        light: "border-red-100",
        base: "border-red-500",
        dark: "border-red-700",
      },
      orange: {
        light: "border-orange-100",
        base: "border-orange-500",
        dark: "border-orange-700",
      },
      amber: {
        light: "border-amber-100",
        base: "border-amber-500",
        dark: "border-amber-700",
      },
      yellow: {
        light: "border-yellow-100",
        base: "border-yellow-500",
        dark: "border-yellow-700",
      },
      lime: {
        light: "border-lime-100",
        base: "border-lime-500",
        dark: "border-lime-700",
      },
      green: {
        light: "border-green-100",
        base: "border-green-500",
        dark: "border-green-700",
      },
      emerald: {
        light: "border-emerald-100",
        base: "border-emerald-500",
        dark: "border-emerald-700",
      },
      teal: {
        light: "border-teal-100",
        base: "border-teal-500",
        dark: "border-teal-700",
      },
      cyan: {
        light: "border-cyan-100",
        base: "border-cyan-500",
        dark: "border-cyan-700",
      },
      sky: {
        light: "border-sky-100",
        base: "border-sky-500",
        dark: "border-sky-700",
      },
      blue: {
        light: "border-blue-100",
        base: "border-blue-500",
        dark: "border-blue-700",
      },
      indigo: {
        light: "border-indigo-100",
        base: "border-indigo-500",
        dark: "border-indigo-700",
      },
      violet: {
        light: "border-violet-100",
        base: "border-violet-500",
        dark: "border-violet-700",
      },
      purple: {
        light: "border-purple-100",
        base: "border-purple-500",
        dark: "border-purple-700",
      },
      fuchsia: {
        light: "border-fuchsia-100",
        base: "border-fuchsia-500",
        dark: "border-fuchsia-700",
      },
      pink: {
        light: "border-pink-100",
        base: "border-pink-500",
        dark: "border-pink-700",
      },
      rose: {
        light: "border-rose-100",
        base: "border-rose-500",
        dark: "border-rose-700",
      },
    };
    this.textColorClasses = {
      slate: {
        light: "text-slate-100",
        base: "text-slate-500",
        dark: "text-slate-700",
      },
      gray: {
        light: "text-gray-100",
        base: "text-gray-500",
        dark: "text-gray-700",
      },
      zinc: {
        light: "text-zinc-100",
        base: "text-zinc-500",
        dark: "text-zinc-700",
      },
      neutral: {
        light: "text-neutral-100",
        base: "text-neutral-500",
        dark: "text-neutral-700",
      },
      stone: {
        light: "text-stone-100",
        base: "text-stone-500",
        dark: "text-stone-700",
      },
      red: {
        light: "text-red-100",
        base: "text-red-500",
        dark: "text-red-700",
      },
      orange: {
        light: "text-orange-100",
        base: "text-orange-500",
        dark: "text-orange-700",
      },
      amber: {
        light: "text-amber-100",
        base: "text-amber-500",
        dark: "text-amber-700",
      },
      yellow: {
        light: "text-yellow-100",
        base: "text-yellow-500",
        dark: "text-yellow-700",
      },
      lime: {
        light: "text-lime-100",
        base: "text-lime-500",
        dark: "text-lime-700",
      },
      green: {
        light: "text-green-100",
        base: "text-green-500",
        dark: "text-green-700",
      },
      emerald: {
        light: "text-emerald-100",
        base: "text-emerald-500",
        dark: "text-emerald-700",
      },
      teal: {
        light: "text-teal-100",
        base: "text-teal-500",
        dark: "text-teal-700",
      },
      cyan: {
        light: "text-cyan-100",
        base: "text-cyan-500",
        dark: "text-cyan-700",
      },
      sky: {
        light: "text-sky-100",
        base: "text-sky-500",
        dark: "text-sky-700",
      },
      blue: {
        light: "text-blue-100",
        base: "text-blue-500",
        dark: "text-blue-700",
      },
      indigo: {
        light: "text-indigo-100",
        base: "text-indigo-500",
        dark: "text-indigo-700",
      },
      violet: {
        light: "text-violet-100",
        base: "text-violet-500",
        dark: "text-violet-700",
      },
      purple: {
        light: "text-purple-100",
        base: "text-purple-500",
        dark: "text-purple-700",
      },
      fuchsia: {
        light: "text-fuchsia-100",
        base: "text-fuchsia-500",
        dark: "text-fuchsia-700",
      },
      pink: {
        light: "text-pink-100",
        base: "text-pink-500",
        dark: "text-pink-700",
      },
      rose: {
        light: "text-rose-100",
        base: "text-rose-500",
        dark: "text-rose-700",
      },
    };
  }

  backgroundColor = (color, variant = "base") =>
    this.backgroundColorClasses[color][variant];
  borderColor = (color, variant = "base") =>
    this.borderColorClasses[color][variant];
  textColor = (color, variant = "base") =>
    this.textColorClasses[color][variant];
}

class FlashCardStyler extends Styler {
  frontClass(flashCard) {
    const { color, card_style } = flashCard;

    const cardFrontClasses = {
      basic: `text-white font-bold rounded-xl shadow-xl ${this.backgroundColor(color)}`,
      fancy: `font-serif font-bold border border-8 font-bold ${this.textColor(color)} ${this.borderColor(color)}`,
      brutalism: `font-cursive font-semibold text-white offset-box-shadow ${this.backgroundColor(color)}`,
    };

    return cardFrontClasses[card_style];
  }

  buttonClass(flashCard) {
    const { color, card_style } = flashCard;

    const buttonClasses = {
      basic: "font-sans text-white border-white",
      fancy: `font-serif bg-white ${this.borderColor(color)}`,
      brutalism: "font-cursive text-white border-white",
    };

    return `px-2 py-1 text-sm rounded border-2 font-bold hover:-translate-y-1.5 duration-100 ${buttonClasses[card_style]}`;
  }

  tagClass(flashCard) {
    const { color } = flashCard;

    return `rounded-lg px-1.5 py-1 text-xs ${this.backgroundColor(color, "light")} ${this.textColor(color)}`;
  }
}

class CollectionStyler extends Styler {
  constructor() {
    super();

    this.beforeBackgroundColors = {
      slate: {
        light: "before:bg-slate-100",
        base: "before:bg-slate-500",
        dark: "before:bg-slate-700",
      },
      gray: {
        light: "before:bg-gray-100",
        base: "before:bg-gray-500",
        dark: "before:bg-gray-700",
      },
      zinc: {
        light: "before:bg-zinc-100",
        base: "before:bg-zinc-500",
        dark: "before:bg-zinc-700",
      },
      neutral: {
        light: "before:bg-neutral-100",
        base: "before:bg-neutral-500",
        dark: "before:bg-neutral-700",
      },
      stone: {
        light: "before:bg-stone-100",
        base: "before:bg-stone-500",
        dark: "before:bg-stone-700",
      },
      red: {
        light: "before:bg-red-100",
        base: "before:bg-red-500",
        dark: "before:bg-red-700",
      },
      orange: {
        light: "before:bg-orange-100",
        base: "before:bg-orange-500",
        dark: "before:bg-orange-700",
      },
      amber: {
        light: "before:bg-amber-100",
        base: "before:bg-amber-500",
        dark: "before:bg-amber-700",
      },
      yellow: {
        light: "before:bg-yellow-100",
        base: "before:bg-yellow-500",
        dark: "before:bg-yellow-700",
      },
      lime: {
        light: "before:bg-lime-100",
        base: "before:bg-lime-500",
        dark: "before:bg-lime-700",
      },
      green: {
        light: "before:bg-green-100",
        base: "before:bg-green-500",
        dark: "before:bg-green-700",
      },
      emerald: {
        light: "before:bg-emerald-100",
        base: "before:bg-emerald-500",
        dark: "before:bg-emerald-700",
      },
      teal: {
        light: "before:bg-teal-100",
        base: "before:bg-teal-500",
        dark: "before:bg-teal-700",
      },
      cyan: {
        light: "before:bg-cyan-100",
        base: "before:bg-cyan-500",
        dark: "before:bg-cyan-700",
      },
      sky: {
        light: "before:bg-sky-100",
        base: "before:bg-sky-500",
        dark: "before:bg-sky-700",
      },
      blue: {
        light: "before:bg-blue-100",
        base: "before:bg-blue-500",
        dark: "before:bg-blue-700",
      },
      indigo: {
        light: "before:bg-indigo-100",
        base: "before:bg-indigo-500",
        dark: "before:bg-indigo-700",
      },
      violet: {
        light: "before:bg-violet-100",
        base: "before:bg-violet-500",
        dark: "before:bg-violet-700",
      },
      purple: {
        light: "before:bg-purple-100",
        base: "before:bg-purple-500",
        dark: "before:bg-purple-700",
      },
      fuchsia: {
        light: "before:bg-fuchsia-100",
        base: "before:bg-fuchsia-500",
        dark: "before:bg-fuchsia-700",
      },
      pink: {
        light: "before:bg-pink-100",
        base: "before:bg-pink-500",
        dark: "before:bg-pink-700",
      },
      rose: {
        light: "before:bg-rose-100",
        base: "before:bg-rose-500",
        dark: "before:bg-rose-700",
      },
    };
  }

  beforeBackgroundColor = (color, variant = "base") =>
    this.beforeBackgroundColors[color][variant];

  displayClass(collection) {
    const { color } = collection;

    return `border-t-4 border-b ${this.backgroundColor(color, "light")} ${this.borderColor(color)} ${this.beforeBackgroundColor(color)} ${this.textColor(color)}`;
  }

  tagClass(collection) {
    const { color } = collection;

    return `rounded-lg px-1.5 py-1 text-xs ${this.backgroundColor(color)} ${this.textColor(color, 'light')}`;
  }
}

export { FlashCardStyler, CollectionStyler };
