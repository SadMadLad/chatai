<template>
  <section>
    <div class="flex items-center">
      <div class="flex w-2/3 flex-col items-start gap-4">
        <h2 class="text-primary-500 text-4xl font-black">Quiz Shop</h2>
        <div>
          <p class="text-primary-700 text-xl">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi,
            dignissimos.
          </p>
          <RouterLink :to="{ name: 'quizzes' }">
            <button
              class="bg-primary-500 hover:bg-secondary-500 rounded px-3.5 py-2.5 font-semibold text-white"
            >
              Explore Quizzes
            </button>
          </RouterLink>
        </div>
      </div>
      <div class="bg-primary-500 w-1/3 border">
        <div class="bg-white pl-8">
          <img src="/hero-image.svg" class="h-auto w-[40rem]" />
        </div>
      </div>
    </div>
  </section>
</template>
