module UberSignals

# package code goes here

abstract LocationType
abstract Online <: LocationType
immutable TCP_IP <: Online end

abstract GPU <: LocationType
immutable OpenGL{Version} <: GPU end
immutable OpenCL{Version} <: GPU end

abstract Disc <: LocationType

immutable CPU <: LocationType end

abstract CachingType
immutable DiscardUpdates <: CachingType end
immutable CacheUpdates <: CachingType end
immutable NoCaching <: CachingType end

abstract MutabilityType
immutable Mutable <: MutabilityType end
immutable Immutable <: MutabilityType end


function call(::Type{MutabilityType}, typ)
    if isimmutable(typ)
        Mutable
    else
        Immutable
    end
end
function call(::Type{LocationType}, typ)
    CPU
end

immutable Signal{T, Mutability <: MutabilityType, Location <: LocationType, Caching <: CachingType, ID}
    value::T
end

begin
id = 0
function Signal{T}(x::T, caching = NoCaching)
    id += 1
    Signal{T, MutabilityType(x), LocationType(x), caching, id}(x)
end
end

@show Signal(1f0)

end # module
