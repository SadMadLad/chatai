<template>
  <section>
    <div class="flex items-center">
      <div class="flex w-2/3 flex-col items-start gap-4">
        <h2 class="text-4xl font-black"></h2>
        <div>
          <p class="font-cursive text-xl">
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
    </div>
  </section>
</template>
