$(document).ready(function () {

    let groups = [...new Set(
        $(".form-check-input").map(function () {
            return this.name;
        }).get()
    )];


    $(".form-check-input").on("change", function () {
        const currentUrl = new URL(window.location.href);
        const searchParams = currentUrl.searchParams;


        searchParams.set("page", "1");

        groups.forEach(name => {

            let checked = $(`input[name='${name}']:checked`).map(function () {
                return this.value;
            }).get();

            if (checked.length > 0) {

                searchParams.set(name, checked.join("-"));
            } else {

                searchParams.delete(name);
            }
        });


        window.location.href = currentUrl.pathname + "?" + searchParams.toString();
    });


    const urlParams = new URLSearchParams(window.location.search);

    groups.forEach(name => {
        if (urlParams.has(name)) {
            let values = urlParams.get(name);


            if ($(`input[name='${name}']`).attr("type") === "radio") {
                $(`input[name='${name}'][value='${values}']`).prop("checked", true);
            }

            else {
                values.split("-").forEach(v => {
                    $(`input[name='${name}'][value='${v}']`).prop("checked", true);
                });
            }
        }
    });

    $(document).ready(function () {
        $(".pagination a").on("click", function (e) {
            e.preventDefault();
            const url = new URL(window.location.href);
            const searchParams = url.searchParams;


            const newPage = $(this).attr("href").split("page=")[1];
            searchParams.set("page", newPage);


            window.location.href = url.pathname + "?" + searchParams.toString();
        });
    });

});
