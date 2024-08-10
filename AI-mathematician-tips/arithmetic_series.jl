### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 89b31a28-0086-4c20-8c47-bbee30a5a3ba
using Base

# ╔═╡ 9eeae930-548a-11ef-3372-b1dacde966a3
using SymPy

# ╔═╡ 6b68b005-5870-4bd9-be96-447f98c7d727
using PyCall

# ╔═╡ 9e6bfb1b-8ce7-4db0-956e-b36da65ba93a
n, a, d = symbols(["n", "a", "d"])

# ╔═╡ a5a97b2f-6423-4ab6-bd0f-5e9d46d0457f
b = n -> 2n-1

# ╔═╡ 205f2e7b-6160-4d9a-8436-06339a174946
b.(1:10)

# ╔═╡ bbbf0e55-284f-4080-a0f1-7a02b0b50440
md"""
	It has been proven that sum of an = 2*n-1 equals n^2. 
	It mean that 1+3+5+...+2*n-1=n^2
"""

# ╔═╡ 1a92671e-e2eb-4d35-a31a-514453d400b7
begin 
	struct GeneralSeries
		a::Sym{PyCall.PyObject}
		d::Sym{PyCall.PyObject}
	end
	(series::GeneralSeries)(m::Sym{PyCall.PyObject}) = series.a + (m-1)*series.d
	Base.:+(series1::GeneralSeries, series2::GeneralSeries) = 		
		GeneralSeries(series1.a+series2.a, series1.d+series2.d)
end

# ╔═╡ 8f09b7a5-c8d5-4690-8488-e1961f421894
begin
	struct Series
		a::Int
		d::Int
	end
	(series::Series)(m::Sym{PyCall.PyObject}) = series.a + (m-1)*series.d
	(series::Series)(m::Int) = series.a + (m-1)*series.d
end

# ╔═╡ ed94a3a6-0238-4770-ae24-eb84d0066a97
series1 = Series(1,2)

# ╔═╡ ffaec41c-b857-4600-9fba-6f195bcb2d4b
function is_sum_square(series1::Series)
	@show aₙ₊₁ = series1(n+1)
	@show Δsₙ = simplify(eval(:((n+1)^2-n^2)))
	if aₙ₊₁ == Δsₙ && series1(1) == 1^2
		return true
	end
	return false
end

# ╔═╡ 1c69b8bb-e173-409a-b317-ba9e60c248f2
is_sum_square(series1)

# ╔═╡ 1a62dd16-06e4-45bd-831d-34f9bea9acd6
is_constant(series::GeneralSeries) = (series.d == 0)

# ╔═╡ 8bbabd60-09b6-4d56-b3c3-0887200437bd
Base.:reverse(series::GeneralSeries) = GeneralSeries(series.a+(n-1)*series.d, -series.d)

# ╔═╡ af04dccc-e5d9-4f23-bb08-127eddca0e11
function is_equal(series1::GeneralSeries, series2::GeneralSeries) 
	if (series1.a == series2.a) && (series1.d == series2.d)
		return true
	elseif (series1.a == reverse(series2).a) && (series1.d == reverse(series2).d)
		return true
	else
		return false
	end
end

# ╔═╡ 41d39785-0103-46f8-b4e9-df8bb94f50b9
function Base.:sum(series1::GeneralSeries)
	series2 = reverse(series1)+series1
	if is_constant(series2)
		return n/2*series2.a
	end
end

# ╔═╡ 227beca1-89f2-402d-8122-4ecd68a97ada
s = n -> sum(b.(1:n))

# ╔═╡ 9a2b2a90-8ea1-4acb-96a3-cecb98a23fcc
s(1)

# ╔═╡ 55f3d649-18dd-4736-b1cd-b5d8899bdf85
s(2)

# ╔═╡ cce1c3f0-6eb3-4111-8377-aaba7b14b5d7
s(3)

# ╔═╡ 204402fe-f67b-4c11-9e2d-416a7645d8d8
s(10)

# ╔═╡ 9f6ec7af-1904-4ef5-a285-e6c19dcde2d7
series2 = GeneralSeries(a, d)

# ╔═╡ 8c873e0f-3469-4ad0-bf76-3f627a07efe5
sum(series2)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
PyCall = "~1.96.4"
SymPy = "~2.2.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "1fb5dcf394f432eefa4c23757ed9af7df51670ef"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CommonEq]]
git-tree-sha1 = "6b0f0354b8eb954cdba708fb262ef00ee7274468"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.1"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "b19db3927f0db4151cb86d073689f2428e524576"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.10.2"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "9816a3826b0ebf49ab4926e2b18842ad8b5c8f04"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.96.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.SymPy]]
deps = ["CommonEq", "CommonSolve", "LinearAlgebra", "PyCall", "SpecialFunctions", "SymPyCore"]
git-tree-sha1 = "d35b297be048dfac05bcff29e55d6106808e3c5a"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "2.2.0"

[[deps.SymPyCore]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "bef92ec4c31804bdc9c44cb00eaf0348eac383fb"
uuid = "458b697b-88f0-4a86-b56b-78b75cfb3531"
version = "0.2.5"

    [deps.SymPyCore.extensions]
    SymPyCoreTermInterfaceExt = "TermInterface"

    [deps.SymPyCore.weakdeps]
    TermInterface = "8ea1fca8-c5ef-4a55-8b96-4e9afe9c9a3c"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═89b31a28-0086-4c20-8c47-bbee30a5a3ba
# ╠═37b4feb4-5492-4fa0-bf9d-c07644e4c5ee
# ╠═9eeae930-548a-11ef-3372-b1dacde966a3
# ╠═6b68b005-5870-4bd9-be96-447f98c7d727
# ╠═9e6bfb1b-8ce7-4db0-956e-b36da65ba93a
# ╠═a5a97b2f-6423-4ab6-bd0f-5e9d46d0457f
# ╠═205f2e7b-6160-4d9a-8436-06339a174946
# ╠═227beca1-89f2-402d-8122-4ecd68a97ada
# ╠═9a2b2a90-8ea1-4acb-96a3-cecb98a23fcc
# ╠═55f3d649-18dd-4736-b1cd-b5d8899bdf85
# ╠═cce1c3f0-6eb3-4111-8377-aaba7b14b5d7
# ╠═204402fe-f67b-4c11-9e2d-416a7645d8d8
# ╠═8f09b7a5-c8d5-4690-8488-e1961f421894
# ╠═ffaec41c-b857-4600-9fba-6f195bcb2d4b
# ╠═ed94a3a6-0238-4770-ae24-eb84d0066a97
# ╠═1c69b8bb-e173-409a-b317-ba9e60c248f2
# ╠═bbbf0e55-284f-4080-a0f1-7a02b0b50440
# ╠═1a92671e-e2eb-4d35-a31a-514453d400b7
# ╠═1a62dd16-06e4-45bd-831d-34f9bea9acd6
# ╠═8bbabd60-09b6-4d56-b3c3-0887200437bd
# ╠═af04dccc-e5d9-4f23-bb08-127eddca0e11
# ╠═41d39785-0103-46f8-b4e9-df8bb94f50b9
# ╠═9f6ec7af-1904-4ef5-a285-e6c19dcde2d7
# ╠═8c873e0f-3469-4ad0-bf76-3f627a07efe5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
