class 'MapEditorShared'

function MapEditorShared:__init()
	print("Initializing MapEditorShared")
	self:RegisterVars()
	self:RegisterEvents()
end


function MapEditorShared:RegisterVars()
	self.m_Instances = {}
end


function MapEditorShared:RegisterEvents()
	self.m_PartitionLoadedEvent = Events:Subscribe('Partition:Loaded', self, self.OnPartitionLoaded)
end


function MapEditorShared:OnPartitionLoaded(p_Partition)
	if p_Partition == nil then
		return
	end
	
	local s_Instances = p_Partition.instances


	for _, l_Instance in ipairs(s_Instances) do
		if l_Instance == nil then
			print('Instance is null?')
			break
		end

		if(l_Instance.typeName == "ObjectBlueprint" or
			l_Instance.typeName == "PrefabBlueprint") then

			local s_Instance = _G[l_Instance.typeName](l_Instance)

			-- We're not storing the actual instance since we'd rather look it up manually in case of a reload.
			self.m_Instances[#self.m_Instances + 1] = {
				instanceGuid = tostring(l_Instance.instanceGuid),
				partitionGuid = tostring(p_Partition.guid),
				name = s_Instance.name,
				typeName = l_Instance.typeName
			}
		end


	end
end

return MapEditorShared

