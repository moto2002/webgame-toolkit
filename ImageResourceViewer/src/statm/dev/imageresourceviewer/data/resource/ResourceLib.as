package statm.dev.imageresourceviewer.data.resource
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import statm.dev.imageresourceviewer.data.Element;
	import statm.dev.imageresourceviewer.data.type.ResourceType;

	/**
	 * 资源库。
	 *
	 * @author statm
	 *
	 */
	public class ResourceLib
	{
		public static var hero : ResourceCategory;
		public static var weapon : ResourceCategory;
		public static var mount : ResourceCategory;
		public static var npc : ResourceCategory;
		public static var mob : ResourceCategory;
		public static var pet : ResourceCategory;
		public static var fx : ResourceCategory;

		public static var unknown : ArrayCollection;

		private static var heroDic : Dictionary;
		private static var weaponDic : Dictionary;
		private static var mountDic : Dictionary;
		private static var npcDic : Dictionary;
		private static var mobDic : Dictionary;
		private static var petDic : Dictionary;
		private static var fxDic : Dictionary;

		public static function reset() : void
		{
			hero = new ResourceCategory(ResourceType.HERO);
			weapon = new ResourceCategory(ResourceType.WEAPON);
			mount = new ResourceCategory(ResourceType.MOUNT);
			npc = new ResourceCategory(ResourceType.NPC);
			mob = new ResourceCategory(ResourceType.MOB);
			pet = new ResourceCategory(ResourceType.PET);
			fx = new ResourceCategory(ResourceType.FX);

			unknown = new ArrayCollection();

			heroDic = new Dictionary();
			weaponDic = new Dictionary();
			mountDic = new Dictionary();
			npcDic = new Dictionary();
			mobDic = new Dictionary();
			petDic = new Dictionary();
			fxDic = new Dictionary();
		}

		public static function addResource(resourceBatch : ResourceBatch) : void
		{
			if (resourceBatch.batchInfo.isComplete)
			{
				var type : String = resourceBatch.batchInfo.type;
				var category : ResourceCategory = getCategory(type);

				var element : Element = getElement(resourceBatch);
				element.addBatch(resourceBatch);

				if (category.elements.getItemIndex(element) == -1)
				{
					category.elements.addItem(element);
				}
			}
			else
			{
				unknown.addItem(resourceBatch);
			}
		}

		private static function getElement(resourceBatch : ResourceBatch) : Element
		{
			var result : Element = getDic(resourceBatch.batchInfo.type)[resourceBatch.batchInfo.name] as Element;

			if (!result)
			{
				result = new Element(resourceBatch.batchInfo.name, resourceBatch.batchInfo.type);
				getDic(resourceBatch.batchInfo.type)[resourceBatch.batchInfo.name] = result;
			}

			return result;
		}

		public static function getCategory(type : String) : ResourceCategory
		{
			switch (type)
			{
				case ResourceType.HERO:
					return hero;

				case ResourceType.WEAPON:
					return weapon;

				case ResourceType.MOUNT:
					return mount;

				case ResourceType.NPC:
					return npc;

				case ResourceType.MOB:
					return mob;

				case ResourceType.PET:
					return pet;

				case ResourceType.FX:
					return fx;
			}

			throw new ArgumentError("Type 错误");
		}

		private static function getDic(type : String) : Dictionary
		{
			switch (type)
			{
				case ResourceType.HERO:
					return heroDic;

				case ResourceType.WEAPON:
					return weaponDic;

				case ResourceType.MOUNT:
					return mountDic;

				case ResourceType.NPC:
					return npcDic;

				case ResourceType.MOB:
					return mobDic;

				case ResourceType.PET:
					return petDic;

				case ResourceType.FX:
					return fxDic;
			}

			throw new ArgumentError("Type 错误");
		}

		public static function print() : void
		{
			trace(hero.elements.source.join());
			trace(weapon.elements.source.join());
			trace(mount.elements.source.join());
			trace(npc.elements.source.join());
			trace(mob.elements.source.join());
			trace(pet.elements.source.join());
			trace(fx.elements.source.join());
		}
	}
}
